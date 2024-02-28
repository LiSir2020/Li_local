using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JrIntercepter.Net
{
    internal class Intercepter
    {
        internal delegate void DelegateUpdateSession(Session session);
        internal static event DelegateUpdateSession OnUpdateSession;

        internal static void UpdateSession(Session session)
        {
            if (OnUpdateSession != null)
            {
                OnUpdateSession(session);  
            }
        }
    }
}
