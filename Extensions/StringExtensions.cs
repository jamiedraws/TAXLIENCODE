using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TAXLIENCODE.Extensions
{
    public static class StringExtensions
    {
        public static string CommaSeparate(this string text)
        {
            return string.IsNullOrEmpty(text) || string.IsNullOrWhiteSpace(text) ? string.Empty : string.Format("{0}, ", text);
        }
    }
}