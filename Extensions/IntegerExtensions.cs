using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAXLIENCODE.Extensions
{
    public static class IntegerExtensions
    {
        public static string AddEnglishOrdinal(this int num)
        {
            string numStr = num.ToString();

            if (numStr.EndsWith("11")) return numStr + "th";

            if (numStr.EndsWith("12")) return numStr + "th";

            if (numStr.EndsWith("13")) return numStr + "th";

            if (numStr.EndsWith("1")) return numStr + "st";

            if (numStr.EndsWith("2")) return numStr + "nd";

            if (numStr.EndsWith("3")) return numStr + "rd";

            return numStr + "th";
        }
    }
}