#ifndef __WEBKIT_2_H__
#define __WEBKIT_2_H__

#include <gtk/gtk.h>
struct _WebKitWebViewBase {
    GtkContainer parentInstance;
};

typedef struct _WebKitWebViewBase WebKitWebViewBase;


struct _WebKitWebView {
    WebKitWebViewBase parent;
};

typedef struct _WebKitWebView WebKitWebView;



#endif /* __WEBKIT2_H__ */
