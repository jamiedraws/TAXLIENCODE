// components
import Carousel from "Shared/ts/components/carousel";
import Accordion from "Shared/ts/components/accordion";
import Nav from "Shared/ts/components/nav";

// adapters
import SlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/slide-carousel";

// observers
import { observer } from "Shared/ts/observers/intersection";

// utils
import Disclosure from "Shared/ts/utils/disclosure";

// applications
import {
    initializeBase,
    initializeMicrosite
} from "Shared/ts/applications/template";
import {
    initializeModalDialogIframe,
    initializeQuestionCodeCheckboxes,
    initializeValidateCommonWithActionCodeRadioGroup,
    initializeValidateEventNavigator,
    initializeValidateEventWithAjaxSubmit
} from "Shared/ts/applications/form";
import Toast from "Shared/ts/components/toast";
import SocialProofController from "ts/applications/social-proof-controller";
import StatusScreen from "Shared/ts/components/status-screen";
import {
    importScrollableHeightByElement,
    initializeNavById
} from "Shared/ts/applications/navigation";

interface NotifyJsDTM {
    callback: () => void;
}

declare global {
    interface Window {
        _njs: NotifyJsDTM;
    }
}

const outputResponse = (response: string | null | undefined): void => {
    const message = response ?? "";
    if (message === "") return;

    toast.post(message);
    toast.show();
};

const toast = new Toast("default");

const initializeValidateSeminarForm = async (): Promise<void> => {
    const form = document.querySelector<HTMLFormElement>(
        "[data-validate-common-form]"
    );
    if (!form) return;

    const submit = form.querySelector<HTMLButtonElement>("#AcceptOfferButton");
    if (!submit) return;

    const statusScreen = new StatusScreen("register-seminar");

    await initializeValidateEventNavigator(form, submit);

    statusScreen.busy("Saving Your Seat...");

    form.submit();
};

const handleSocialProofCallback = async () => {
    const spc = new SocialProofController(window.location.origin);

    await spc.setFocusToTargetByUrlFragment();

    window._njs.callback = () => {
        spc.getTargetElement()
            .then((element) => spc.setFocusToTarget())
            .catch((error) => {
                spc.getDestinationUrlTargetId()
                    .then((url) => (window.location.href = url))
                    .catch((error) => console.debug(error));
            });
    };
};

// addEventListener("load", handleSocialProofCallback);

const initializeValidateInviteAGuest = (): void => {
    const form = document.querySelector(
        "[data-validate-form]"
    ) as HTMLFormElement;
    if (!form) return;

    const submit = form.querySelector(
        `[data-validate-form-type="submit"]`
    ) as HTMLButtonElement;
    if (!submit) return;

    initializeValidateEventWithAjaxSubmit(form, submit, outputResponse);
};

initializeBase();
initializeMicrosite();

initializeModalDialogIframe();

initializeValidateSeminarForm();
// initializeValidateInviteAGuest();

const nav = initializeNavById("nav");
importScrollableHeightByElement(nav?.root);

observer(".slide--carousel", {
    inRange: (element) => {
        const carousel = new Carousel(new SlideCarouselAdapter(element));

        carousel.enablePrevNextControls();
    }
});

observer(".accordion", {
    inRange: (element) => new Accordion(element)
});

observer(".content-reveal", {
    inRange: (element) => element.classList.add("content-reveal--is-visible")
});
