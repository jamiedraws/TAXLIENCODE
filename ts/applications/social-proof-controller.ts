import { getSettingByCode } from "Shared/ts/api/campaign-manager/settings-manager";

export default class SocialProofController {
    private static targetSelector: string | null;

    private static targetId: WeakMap<SocialProofController, string> =
        new WeakMap<SocialProofController, string>();

    private static targetElement: WeakMap<SocialProofController, HTMLElement> =
        new WeakMap<SocialProofController, HTMLElement>();

    private static parser: DOMParser = new DOMParser();

    public destinationUrl: string;

    constructor(destinationUrl: string) {
        this.destinationUrl = destinationUrl;

        this.allowTargetToFocus().catch((error) => console.debug(error));
    }

    private async allowTargetToFocus(): Promise<void> {
        const target = await this.getTargetElement();

        const tabindex = target.getAttribute("tabindex");
        if (tabindex) return;

        target.setAttribute("tabindex", "-1");
    }

    public async getTargetSelector(): Promise<string> {
        const cacheTargetSelector = SocialProofController.targetSelector;
        if (cacheTargetSelector) return cacheTargetSelector;

        const targetSelector = await getSettingByCode(
            "PopUpSlider.CallToActionScrollToTarget"
        );
        if (targetSelector === "") {
            throw {
                message: `There is no target id assigned to the social proof`
            };
        }

        SocialProofController.targetSelector = targetSelector;

        return targetSelector;
    }

    public async getDestinationUrlTargetId(): Promise<string> {
        const targetId = await this.getTargetId();

        return `${this.destinationUrl}#${targetId}`;
    }

    public async getTargetElement(): Promise<HTMLElement> {
        const cacheTargetElement =
            SocialProofController.targetElement.get(this);
        if (cacheTargetElement) return cacheTargetElement;

        const targetSelector = await this.getTargetSelector();

        const targetElement =
            document.querySelector<HTMLElement>(targetSelector);
        if (!targetElement) {
            throw {
                message: `The HTMLElement representing the social proof target could not be located in the current document using the provided identifier.`,
                targetSelector
            };
        }

        SocialProofController.targetElement.set(this, targetElement);

        return targetElement;
    }

    public async getTargetElementFromDestinationUrl(): Promise<HTMLElement> {
        const cacheTargetElement =
            SocialProofController.targetElement.get(this);
        if (cacheTargetElement) return cacheTargetElement;

        const targetSelector = await this.getTargetSelector();

        const request = await fetch(this.destinationUrl);
        const response = await request.text();

        const destinationDocument =
            SocialProofController.parser.parseFromString(response, "text/html");
        const targetElement =
            destinationDocument.querySelector<HTMLElement>(targetSelector);

        if (!targetElement) {
            throw {
                message: `The HTMLElement representing the social proof target could not be located in the document from the destination URL using the provided identifier.`,
                targetSelector
            };
        }

        SocialProofController.targetElement.set(this, targetElement);

        return targetElement;
    }

    public async getTargetId(): Promise<string> {
        const cacheTargetId = SocialProofController.targetId.get(this);
        if (cacheTargetId) return cacheTargetId;

        const targetElement = await this.getTargetElement().catch(() =>
            this.getTargetElementFromDestinationUrl()
        );

        const targetId = targetElement.id;
        if (!targetId) {
            throw {
                message: `The target HTMLElement does not have a unique id associated with it and cannot be focused on`,
                element: targetElement
            };
        }

        SocialProofController.targetId.set(this, targetId);

        return targetId;
    }

    public async setFocusToTarget(): Promise<void> {
        const target = await this.getTargetElement();
        if (!target.hasAttribute("tabindex")) {
            throw {
                message: `The target HTMLElement does not have the [tabindex] attribute applied. This program will not set focus to the target element.`,
                target
            };
        }

        target.focus();
    }

    public async setFocusToTargetByUrlFragment(): Promise<void> {
        const fragment = window.location.hash;
        if (fragment === "") return;

        const id = await this.getTargetId();
        if (fragment !== id) return;

        this.setFocusToTarget();
    }
}
