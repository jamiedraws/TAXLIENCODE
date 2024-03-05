<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="TAXLIENCODE.Navigation" %>
<%@ Import Namespace="TAXLIENCODE.UIComponents" %>
<%@ Import Namespace="TAXLIENCODE.Models" %>
<%@ Import Namespace="TAXLIENCODE.Text" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;

    OrderButton orderButton = new OrderButton();
%>

<main aria-labelledby="headline" class="view section atf">
    <div class="view__anchor" id="main"></div>
    <div class="view__in section__in">
        <div class="atf">
            <div class="atf__group">
                <div class="atf__header">
                    <h1 id="headline" class="atf__title"><span class="accent">FREE</span> Tax Lien Investing Event</h1>
                    <span>We help potential and experienced investors break free from single-digit annual returns for traditional investment vehicles that gain real double-digit annual passive income!</span>
                </div>

                <div class="atf__form">
                    <%= Html.Partial("OrderForm") %>
                </div>

                <article class="atf__text">
                    <div class="atf__text view__scroll">
                        <div data-src-iframe="https://player.vimeo.com/video/877920026" data-attr='{ "width" : "525", "height" : "295", "title" : "Video", "allow" : "fullscreen" }' class="atf__video contain contain--video">
                            <picture>
                                <img src="/images/Site1/video-poster.webp" alt="" width="570" height="321" loading="lazy">
                            </picture>
                        </div>
    
                        <div class="atf__feature-logos">
                            <b>Featured On</b>
                            <picture>
                                <source srcset="/images/Site1/entrepreneur-logo.webp" type="image/webp">
                                <img src="/images/Site1/entrepreneur-logo.png" alt="Entrepreneur" width="161" height="31" loading="lazy">
                            </picture>
                            <picture>
                                <source srcset="/images/Site1/new-york-times-magazine.webp" type="image/webp">
                                <img src="/images/Site1/new-york-times-magazine.png" alt="New York Times Magazine" width="138" height="50" loading="lazy">
                            </picture>
                        </div>
    
                        <h2 class="atf__headline">If you're tired of...</h2>
                        <ul class="list list--check atf__list">
                            <li>Seeing single-digit annual returns</li>
                            <li>Not having your return mandated by the government</li>
                            <li>Having a second job as an investor</li>
                        </ul>

                        <h2 class="atf__headline">It's time for...</h2>
                        <ul class="list list--check-fill atf__list">
                            <li>Seeing consistent double-digit returns</li>
                            <li>An investment vehicle where the government mandates returns from 8 - 30%</li>
                            <li>Building wealth passively and enjoying your time</li>
                        </ul>

                        <hr>
                        <p class="atf__details"><b>Our goal is to help you understand</b> the fundamentals of how tax liens work, how to find good deals, avoid bad deals, and understand nuances to sidestep potential mistakes. We will cover as much as we can in the short time we will have together.</p>
                    </div>
                </article>
            </div>
        </div>
    </div>
</main>

<section aria-labelledby="text-picture-title" class="view text-picture section">
    <div id="text-picture" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="text-picture__group">
            <picture class="text-picture__picture">
                <img src="/images/Site1/speaker-photo.jpg" alt="" role="presentation" width="325" height="200" loading="lazy">
            </picture>
            <div class="text-picture__text">
                <h2 id="text-picture" class="text-picture__title">Financial success taking too long to reach?</h2>
                <p>Tax lien investing is often ignored because most people don't know how to navigate the process successfully. So, they opt for what they understand, which is often single-family investing. Unfortunately, that crowded path to success is often tediously slow and a lot of work.</p>
            </div>
        </div>
    </div>
</section>

<section aria-labelledby="learn-title" class="view learn section">
    <div id="learn" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="learn__group">
            <div class="learn__header content-reveal">
                <h2 id="learn-title" class="learn__title">HERE'S HOW WE CAN HELP</h2>
            </div>
            <figure class="learn__figure content-reveal content-reveal--from-right">
                <picture class="learn__icon">
                    <source srcset="/images/Site1/icon-hat.webp" type="image/webp">
                    <img src="/images/Site1/icon-hat.png" alt="" role="presentation" width="168" height="90" loading="lazy">
                </picture>
                <figcaption class="learn__figcaption">
                    <h3>Intro Events</h3>
                    <p>This free event lays the foundation for accelerated success through tax lien investing. Buckle your seatbelt. You're about to leave Kansas.</p>
                </figcaption>
            </figure>
            <figure class="learn__figure content-reveal content-reveal--from-bottom">
                <picture class="learn__icon">
                    <source srcset="/images/Site1/icon-tools.webp" type="image/webp">
                    <img src="/images/Site1/icon-tools.png" alt="" role="presentation" width="94" height="92" loading="lazy">
                </picture>
                <figcaption class="learn__figcaption">
                    <h3>Advanced Trainings</h3>
                    <p>We show you how to raise the capital you need to make the deal happen.</p>
                </figcaption>
            </figure>
            <figure class="learn__figure content-reveal content-reveal--from-left">
                <picture class="learn__icon">
                    <source srcset="/images/Site1/icon-connected.webp" type="image/webp">
                    <img src="/images/Site1/icon-connected.png" alt="" role="presentation" width="89" height="90" loading="lazy">
                </picture>
                <figcaption class="learn__figcaption">
                    <h3>Connections</h3>
                    <p>Connect with our network of institutional investors to start putting government tax policies to work for you and achieve double-digit rates of return.</p>
                </figcaption>
            </figure>
        </div>
    </div>
</section>

<section class="view info section" aria-labelledby="info-title">
    <div id="info" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="info__text">
            <h2 id="info-title" class="info__title">If you&rsquo;ve ever thought, there has to be an investment vehicle that is backed by the government and has mandated double-digit returns... <span class="info__callout">you&rsquo;re absolutely correct!</span></h2>
            <p class="info__desc">In fact... these traditional investments could be keeping you from achieving true freedom as an investor.</p>
            <picture class="content-reveal content-reveal--from-bottom">
                <source srcset="/images/Site1/sail-boat-photo.webp" type="image/webp">
                <img src="/images/Site1/sail-boat-photo.jpg" alt="Young family with 2 children sailing on a boat near the docks" width="910" height="480" loading="lazy">
            </picture>
            <b class="info__title">Create you ideal future by investing in tax liens.</b>
            
            <div class="info__button">
                <%= orderButton.CreateHTML() %>
            </div>

            <hr>

            <h2 class="info__title">Meet Tax Lien Code and Let's Create Your Ideal Future Together!</h2>
            <p>We've been there... looking for alternative ways to passively invest only to see our wealth creep up at a snails pace, wondering if we'll ever have enough to achieve financial freedom.</p>
            <p>We&rsquo;re Tax Lien Code, and many of us started out exactly where you are. We invested in opportunity after opportunity only to be disappointed by the "next big investment". The only problem was these so-called "passive" income streams weren't passive at all or never yielded the type of returns that got us excited. We knew there had to be a truly passive way to invest, without having to be an accredited investor, that could <b>grow our wealth at the pace we wanted.</b></p>
            <p>And we can tell you that of all investing we've done, this has been the most passive form of investing that doesn't require a six-figure investment to get started. In fact you can start with as little as $500.</p>
            <p>Every year about 20 - 30% of home owners default on their property taxes. That's over $12,000,000,000 in property taxes that go unpaid and become available as tax lien certificates to investors like you and me. The local governments obviously want their tax revenue so they issue tax certificates that investors like you and I can invest in AND they (the government) <b>mandates an annual rate of return between 8 - 30%!!!</b></p>
            <p>Fast forward a few years and we've now done over $40,000,000 in Tax Liens.</p>
            <p>And it's not just us, <b>90% of individuals</b> that come to our advanced training <b>purchased at least one tax lien within two weeks</b> of attending!</p>
            <p>We've now helped over 40,000 people who have invested in over $30,000,000 worth of tax liens.</p>
            <p>Why? Because it works... <b>Now it's your turn!</b></p>
        </div>
    </div>
</section>

<section aria-labelledby="about-title" class="view about section">
    <div id="about" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="about__group">
            <picture data-view="desktop" class="about__picture content-reveal content-reveal--from-right">
                <source srcset="/images/Site1/brian-photo.webp" type="image/webp">
                <img src="/images/Site1/brian-photo.png" alt="Brian Petersen" width="533" height="813" loading="lazy">
            </picture>
            <div class="about__text-container">
                <div class="about__text content-reveal content-reveal--from-left">
                    <div class="about__header">
                        <picture data-view="mobile">
                            <source srcset="/images/Site1/brian-photo-circle.webp" type="image/webp">
                            <img src="/images/Site1/brian-photo-circle.png" alt="Brian Petersen" width="240" height="240" loading="lazy">
                        </picture>
                        <h2 id="about-title" class="about__title">About<br>Brian Petersen</h2>
                    </div>

                    <p>Brian Petersen has always had his eye on real estate. Early on seeing the many TV Gurus flipping homes had him intrigued so he dropped out of college to pursue Real Estate in 2005.</p>
                    <p>He started having success flipping single-family homes, wholesaling, etc all the way up until the market crashed in 2008.</p>
                    <p>After the 2008 crash Brian found short term single-family and multifamily real estate deals. And while the cash flow was good he quickly realized he had created a "JOB" not to mention his rates of return were low on single-family real estate and multifamily.</p>
                    <p>He was still spending a ton of time "MANAGING" and had traded one headache for another. Evicting tenants, having to be a constant problem solver, having to deal with unruly tenants or having to put up tenants in a hotel because something went bad at one of his multifamily units. And the list goes on.</p>
                    <p>He wanted Freedom, not that he would never have to work, but wanted a passive way to invest in real estate. That's when he discovered Tax Liens.</p>
                    <p>Since that time, he and his partners have done over $40 Million in Tax Liens and also discovered his passion for helping other real estate investors "find the light". He's now educated over 40,000 investors leverage one of the safest real estate investments and help his students invest in over $30 Million worth of Tax Liens.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section aria-labelledby="review-title" class="view review section">
    <div id="testimonials" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="review__header">
            <h2 id="review-title" class="review__title">Don&rsquo;t Just Take Our Word For It.</h2>
            <p>We&rsquo;ve had over 100,000 people register for our live events. See what our students are saying!</p>
        </div>
        <div class="review__list slide slide--carousel content-reveal content-reveal--from-bottom">
            <div class="slide__into" tabindex="0" id="carousel">
                <div class="slide__item review__item">
                    <figure class="review__figure">
                        <picture>
                            <source srcset="/images/Site1/dan-cara.webp" type="image/webp">
                            <img src="/images/Site1/dan-cara.jpg" alt="Dan & Cara" width="150" height="150" loading="lazy">
                        </picture>
                        <figcaption>
                            <h3>Take the plunge. Get out of the rat race!</h3>
                            <blockquote>&ldquo;We got a couple rental properties in Texas and wanted to see more of the market. I&rsquo;m a business administrator and bookkeeper and recently left W2 employment to focus full time on real estate investing. We&rsquo;re really looking for freedom to be able to spend our time the way we want to. I don&rsquo;t think &ldquo;work&rdquo; is a bad word, we are both really active and would love to continue working, but having passive income and have money not be an issue and just be able to do whatever we want is our biggest goal. We purchased a bunch of liens with Randy at the foundation. I just want to say all the coaches are fantastic!&rdquo;</blockquote>
                            <cite>Dan & Cara</cite> 
                        </figcaption>
                    </figure>
                </div>
                <div class="slide__item review__item">
                    <figure class="review__figure">
                        <picture>
                            <source srcset="/images/Site1/john-julia.webp" type="image/webp">
                            <img src="/images/Site1/john-julia.jpg" alt="John & Julia" width="150" height="150" loading="lazy">
                        </picture>
                        <figcaption>
                            <h3>Do it. Definitely Do it!</h3>
                            <blockquote>&ldquo;We are currently retired and we started doing tax liens so we can stay retired. When we found out about tax lien code we didn&rsquo;t realize there were so many different avenues to make money through tax lien code. What we found out at this expo is how many different ways there are to invest your money, or someone else&rsquo;s money, and make a profit. Right here at this function someone was able to walk us through and place our first bid on a tax lien. In 3 years we plan on having income properties making a profit that we can leave to our kids to make their life easier. Have a legacy to leave to our children.&rdquo;</blockquote>
                            <cite>John & Julia</cite> 
                        </figcaption>
                    </figure>
                </div>
                <div class="slide__item review__item">
                    <figure class="review__figure">
                        <picture>
                            <source srcset="/images/Site1/teresa.webp" type="image/webp">
                            <img src="/images/Site1/teresa.jpg" alt="Teresa" width="150" height="150" loading="lazy">
                        </picture>
                        <figcaption>
                            <h3>They really know what they are talking about</h3>
                            <blockquote>&ldquo;One of my aspirations is to get my nonprofit its own space. Then buy, flip and sell properties. There is a lot of good information! They really know what they are talking about, they do a great job of explaining things and it&rsquo;s not intimidating. I love the energy! It&rsquo;s been a lot of fun and a lot of laughs. You&rsquo;re not sitting there bored to tears. I think it&rsquo;s a good approach and its coming from people who are actually doing it and being successf</blockquote>
                            <cite>Teresa</cite> 
                        </figcaption>
                    </figure>
                </div>
            </div>
            <div class="slide__nav">
                <button aria-label="Previous" class="slide__prev" type="button">
                    <svg class="icon">
                        <use href="#icon-chevron"></use>
                    </svg>
                </button>
                <button aria-label="Next" class="slide__next" type="button">
                    <svg class="icon">
                        <use href="#icon-chevron"></use>
                    </svg>
                </button>
            </div>
        </div>
        <div class="review__footer">
            <%= orderButton.CreateHTML() %>
        </div>
    </div>
</section>

<section aria-labelledby="faq-title" class="view faq section">
    <div id="faq" class="view__anchor"></div>
    <div class="view__in faq__in section__in">
        <div class="faq__header">
            <h2 id="faq-title" class="faq__title">Frequently Asked Questions</h2>
            <p>Below are the top 5 questions asked.</p>
            <%
                NavigationItem faqLink = sitemap.GetItemById("faq-page");
                
                if (sitemap.HasItem(faqLink))
                {
                    %>
                    <a href="<%= faqLink.Page %>">Click here to view more frequently asked questions</a>
                    <%
                }
            %>
        </div>
        <%
            List<string> faqQuestionSearchKeywords = new List<string>
            {
                "covered at the",
                "cost me anything",
                "3 day workshop",
                "asl interpreter",
                "dress code"
            };

            List<FAQ> featuredFAQ = ServiceFAQ.General.Where(faq => faqQuestionSearchKeywords.Any(keyword => faq.Question.ToLower().Contains(keyword))).OrderBy(faq =>
            {
                string keyword = faqQuestionSearchKeywords.FirstOrDefault(kw => faq.Question.ToLower().Contains(kw)) ?? string.Empty;

                return faqQuestionSearchKeywords.IndexOf(keyword);
            }).ToList();

            string faqHTML = FAQAccordion.CreateCategorySection(new FAQSection
            {
                Code = "TOP",
                Id = "top-questions",
                Name = "Top 5 Questions"
            }, featuredFAQ, FAQAccordion.HTMLContainer);

            faqHTML = faqHTML.Replace(@"class=""card""", @"class=""card card--shadow-containers""");

            Response.Write(faqHTML);
        %>
        <div class="faq__footer">
            <%= orderButton.CreateHTML() %>
        </div>
    </div>
</section>

</asp:Content>