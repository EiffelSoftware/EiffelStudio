/*
This is a Win32 C function to embed a Internal Explorer object
(actually, an OLE object) in your own window (in order to 
display a web page, or an HTML file on disk).

This requires IE 5.0 (or better) -- due to the IDocHostUIHandler interface,
or a browser that supports the same level of OLE in-place activation.

Most codes bases on Jeff Glatt's source codes:
http://www.codeproject.com/KB/COM/cwebpage.aspx
*/

#ifndef _eif_web_browser_h_
#define _eif_web_browser_h_

#include <windows.h>
extern void UnEmbedBrowserObject(HWND hwnd);
extern long EmbedBrowserObject(HWND hwnd);
extern long DisplayHTMLPage(HWND hwnd, LPTSTR webPageName);
extern long DisplayHTMLStr(HWND hwnd, LPTSTR string);
extern void DoPageAction(HWND hwnd, DWORD action);
extern void ResizeBrowser(HWND hwnd, DWORD width, DWORD height);

#endif
