using System.Collections.Generic;
using TAXLIENCODE.Models;

namespace TAXLIENCODE.Text
{
    public static class ServiceFAQ
    {
        public static List<FAQ> General = new List<FAQ>
        {
            new FAQ
            {
                Question = @"What will be covered at the event?",
                Answer = @"<p>Our goal is to help you understand the fundamentals of how tax liens work, how to find good deals, avoid bad deals, and understand nuances to sidestep potential mistakes. We will cover as much as we can in the short time we will have together.</p>"
            },
            new FAQ 
            { 
                Question = @"Will the event cost me anything?",
                Answer = @"This is a free 90 minute event designed to cover as much information about investing in tax Lien certificates without any previous experience. We will cover as much as we can in the short time we have together. We have an option to continue learning with us at a 3 day workshop. It will be a fun and relaxed environment so the workshop is only an option to consider."
            },
            new FAQ
            {
                Question = @"What is the cost of the 3 day workshop?",
                Answer = @"<p>The cost of the 3-day workshop is $997. Our team will teach you everything you need to know to turn Tax liens from a side hustle into your main source of income. Everything we do is transparent so we can develop a relationship of trust and help you have success in investing in Tax Liens.</p>"
            },
            new FAQ
            {
                Question = @"ASL Interpreter?",
                Answer = @"<p>If someone needs a sign language interpreter please follow this new protocol. Let them know that we would be happy to assist with this. In order to find someone in their area please ask if they have a number or contact of an individual or company that they have used in the past so that we could reach out. Then share their name and information with Lisa and watch for the follow up information. Please share the additional information they provide as well. Most companies require us to give at least 24 hours to find an available ASL interpreter.</p>"
            },
            new FAQ
            {
                Question = @"What is the dress code?",
                Answer = @"<p>You may wear whatever you are comfortable in.</p>"
            }
        };
    }
}