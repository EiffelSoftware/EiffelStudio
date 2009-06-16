note
	description: "Summary description for {NS_APPLICATION_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLICATION_API

feature -- Initialization

	frozen init
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					[[NSGarbageCollector defaultCollector] disable]; // FIXME, garbage collection disabled for development
					ProcessSerialNumber psn;
					[NSApplication sharedApplication];
					// This makes sure that a dock icon is shown for the application
					GetCurrentProcess(&psn);
					TransformProcessType(&psn, 1);
					SetFrontProcess(&psn);
				}
			]"
		end

feature -- Getting the Application

	frozen get: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSApp;"
		end

feature -- Configuring Applications

	frozen set_application_icon_image (a_application, a_image: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSApp setApplicationIconImage: $a_image];"
		end

feature -- Launching Applications

	frozen set_main_menu (a_application, a_menu: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[NSApp setMainMenu: $a_menu];"
		end

feature -- Terminating Applications

	frozen update_windows (a_application: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSApplication*)$a_application updateWindows];"
		end

	frozen send_event (a_application, an_event: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSApplication*)$a_application sendEvent:$an_event];"
		end

--+ (NSApplication *)sharedApplication;
--- (void)setDelegate:(id)anObject;
--- (id)delegate;
--- (NSGraphicsContext*)context;
--- (void)hide:(id)sender;
--- (void)unhide:(id)sender;
--- (void)unhideWithoutActivation;
--- (NSWindow *)windowWithWindowNumber:(NSInteger)windowNum;
--- (NSWindow *)mainWindow;
--- (NSWindow *)keyWindow;
--- (BOOL)isActive;
--- (BOOL)isHidden;
--- (BOOL)isRunning;
--- (void)deactivate;
--- (void)activateIgnoringOtherApps:(BOOL)flag;

--- (void)hideOtherApplications:(id)sender;
--- (void)unhideAllApplications:(id)sender;

	frozen finish_launching (a_application: POINTER)
			-- - (void)finishLaunching;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSApplication*)$a_application finishLaunching];"
		end


--- (void)stop:(id)sender;
--- (void)stopModal;
--- (void)stopModalWithCode:(NSInteger)returnCode;
--- (void)abortModal;
--- (NSWindow *)modalWindow;
--- (NSModalSession)beginModalSessionForWindow:(NSWindow *)theWindow;
--- (NSInteger)runModalSession:(NSModalSession)session;
--- (void)endModalSession:(NSModalSession)session;
	frozen terminate (a_application: POINTER; a_sender: POINTER)
			--- (void)terminate:(id)sender;
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSApplication*)$a_application terminate: $a_sender];"
		end

--enum {
--      NSCriticalRequest = 0,
--      NSInformationalRequest = 10
--};
--typedef NSUInteger NSRequestUserAttentionType;

--// inform the user that this application needs attention - call this method only if your application is not already active
--- (NSInteger)requestUserAttention:(NSRequestUserAttentionType)requestType;
--- (void)cancelUserAttentionRequest:(NSInteger)request;

--/*
--**  Present a sheet on the given window.  When the modal session is ended,
--** the didEndSelector will be invoked in the modalDelegate.  The didEndSelector
--** should have the following signature, and will be invoked when the modal session ends.
--** This method should dimiss the sheet using orderOut:
--** - (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;
--**
--*/
--- (void)beginSheet:(NSWindow *)sheet modalForWindow:(NSWindow *)docWindow modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;
--- (void)endSheet:(NSWindow *)sheet;
--- (void)endSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode;

--/*
--** runModalForWindow:relativeToWindow: is deprecated.
--** Please use beginSheet:modalForWindow:modalDelegate:didEndSelector:contextInfo:
--*/
--- (NSInteger)runModalForWindow:(NSWindow *)theWindow relativeToWindow:(NSWindow *)docWindow;

--/*
--** beginModalSessionForWindow:relativeToWindow: is deprecated.
--** Please use beginSheet:modalForWindow:modalDelegate:didEndSelector:contextInfo:
--*/
--- (NSModalSession)beginModalSessionForWindow:(NSWindow *)theWindow relativeToWindow:(NSWindow *)docWindow;
--- (NSEvent *)nextEventMatchingMask:(NSUInteger)mask untilDate:(NSDate *)expiration inMode:(NSString *)mode dequeue:(BOOL)deqFlag;
--- (void)discardEventsMatchingMask:(NSUInteger)mask beforeEvent:(NSEvent *)lastEvent;
--- (void)postEvent:(NSEvent *)event atStart:(BOOL)flag;
--- (NSEvent *)currentEvent;

--- (void)sendEvent:(NSEvent *)theEvent;
--- (void)preventWindowOrdering;
--- (NSWindow *)makeWindowsPerform:(SEL)aSelector inOrder:(BOOL)flag;
--- (NSArray *)windows;
--- (void)setWindowsNeedUpdate:(BOOL)needUpdate;
--- (void)updateWindows;

--- (void)setMainMenu:(NSMenu *)aMenu;
--- (NSMenu *)mainMenu;

--- (void)setApplicationIconImage:(NSImage *)image;
--- (NSImage *)applicationIconImage;

--- (NSDockTile *)dockTile;

--- (BOOL)sendAction:(SEL)theAction to:(id)theTarget from:(id)sender;
--- (id)targetForAction:(SEL)theAction;
--- (id)targetForAction:(SEL)theAction to:(id)theTarget from:(id)sender;
--- (BOOL)tryToPerform:(SEL)anAction with:(id)anObject;
--- (id)validRequestorForSendType:(NSString *)sendType returnType:(NSString *)returnType;

--- (void)reportException:(NSException *)theException;
--+ (void)detachDrawingThread:(SEL)selector toTarget:(id)target withObject:(id)argument;

--/*  If an application delegate returns NSTerminateLater from -applicationShouldTerminate:, -replyToApplicationShouldTerminate: must be called with YES or NO once the application decides if it can terminate */
--- (void)replyToApplicationShouldTerminate:(BOOL)shouldTerminate;
--enum {
--    NSApplicationDelegateReplySuccess = 0,
--    NSApplicationDelegateReplyCancel = 1,
--    NSApplicationDelegateReplyFailure = 2
--};
--typedef NSUInteger NSApplicationDelegateReply;

--/* If an application delegate encounters an error while handling -application:openFiles: or -application:printFiles:, -replyToOpenOrPrint: should be called with NSApplicationDelegateReplyFailure.  If the user cancels the operation, NSApplicationDelegateReplyCancel should be used, and if the operation succeeds, NSApplicationDelegateReplySuccess should be used */
--- (void)replyToOpenOrPrint:(NSApplicationDelegateReply)reply;

--/* Opens the character palette
--*/
--- (void)orderFrontCharacterPalette:(id)sender;

--@interface NSApplication(NSWindowsMenu)
--- (void)setWindowsMenu:(NSMenu *)aMenu;
--- (NSMenu *)windowsMenu;
--- (void)arrangeInFront:(id)sender;
--- (void)removeWindowsItem:(NSWindow *)win;
--- (void)addWindowsItem:(NSWindow *)win title:(NSString *)aString filename:(BOOL)isFilename;
--- (void)changeWindowsItem:(NSWindow *)win title:(NSString *)aString filename:(BOOL)isFilename;
--- (void)updateWindowsItem:(NSWindow *)win;
--- (void)miniaturizeAll:(id)sender;
--@end

--@interface NSObject(NSApplicationNotifications)
--- (void)applicationWillFinishLaunching:(NSNotification *)notification;
--- (void)applicationDidFinishLaunching:(NSNotification *)notification;
--- (void)applicationWillHide:(NSNotification *)notification;
--- (void)applicationDidHide:(NSNotification *)notification;
--- (void)applicationWillUnhide:(NSNotification *)notification;
--- (void)applicationDidUnhide:(NSNotification *)notification;
--- (void)applicationWillBecomeActive:(NSNotification *)notification;
--- (void)applicationDidBecomeActive:(NSNotification *)notification;
--- (void)applicationWillResignActive:(NSNotification *)notification;
--- (void)applicationDidResignActive:(NSNotification *)notification;
--- (void)applicationWillUpdate:(NSNotification *)notification;
--- (void)applicationDidUpdate:(NSNotification *)notification;
--- (void)applicationWillTerminate:(NSNotification *)notification;
--- (void)applicationDidChangeScreenParameters:(NSNotification *)notification;
--@end

--// return values for -applicationShouldTerminate:
--enum {
--        NSTerminateCancel = 0,
--        NSTerminateNow = 1,
--        NSTerminateLater = 2
--};
--typedef NSUInteger NSApplicationTerminateReply;

--// return values for -application:printFiles:withSettings:showPrintPanels:.
--enum {
--    NSPrintingCancelled = 0,
--    NSPrintingSuccess = 1,
--    NSPrintingFailure = 3,
--    NSPrintingReplyLater = 2
--};
--typedef NSUInteger NSApplicationPrintReply;

--@interface NSObject(NSApplicationDelegate)
--/*
--    Allowable return values are:
--        NSTerminateNow - it is ok to proceed with termination
--        NSTerminateCancel - the application should not be terminated
--        NSTerminateLater - it may be ok to proceed with termination later.  The application must call -replyToApplicationShouldTerminate: with YES or NO once the answer is known
--            this return value is for delegates who need to provide document modal alerts (sheets) in order to decide whether to quit.
--*/
--- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender;
--- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename;
--- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames;
--- (BOOL)application:(NSApplication *)sender openTempFile:(NSString *)filename;
--- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender;
--- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender;
--- (BOOL)application:(id)sender openFileWithoutUI:(NSString *)filename;
--- (BOOL)application:(NSApplication *)sender printFile:(NSString *)filename;
--- (NSApplicationPrintReply)application:(NSApplication *)application printFiles:(NSArray *)fileNames withSettings:(NSDictionary *)printSettings showPrintPanels:(BOOL)showPrintPanels;
--// -application:printFiles: is now deprecated. Implement application:printFiles:withSettings:showPrintPanels: in your application delegate instead.
--- (void)application:(NSApplication *)sender printFiles:(NSArray *)filenames;
--- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;
--- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag;
--- (NSMenu *)applicationDockMenu:(NSApplication *)sender;
--- (NSError *)application:(NSApplication *)application willPresentError:(NSError *)error;
--@end

--@interface NSApplication(NSServicesMenu)
--- (void)setServicesMenu:(NSMenu *)aMenu;
--- (NSMenu *)servicesMenu;
--- (void)registerServicesMenuSendTypes:(NSArray *)sendTypes returnTypes:(NSArray *)returnTypes;
--@end

--@interface NSObject(NSServicesRequests)
--- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard types:(NSArray *)types;
--- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard;
--@end

--@interface NSApplication(NSServicesHandling)
--- (void)setServicesProvider:(id)provider;
--- (id)servicesProvider;
--@end

--@interface NSApplication(NSStandardAboutPanel)
--- (void)orderFrontStandardAboutPanel:(id)sender;
--- (void)orderFrontStandardAboutPanelWithOptions:(NSDictionary *)optionsDictionary;


--/* Optional keys in optionsDictionary:

--@"Credits": NSAttributedString displayed in the info area of the panel. If
--not specified, contents obtained from "Credits.rtf" in [NSBundle mainBundle];
--if not available, blank.

--@"ApplicationName": NSString displayed in place of the default app name. If
--not specified, uses the value of CFBundleName (localizable). Fallback is [[NSProcessInfo processInfo] processName].

--@"ApplicationIcon": NSImage displayed in place of NSApplicationIcon. If not
--specified, use [NSImage imageNamed:@"NSApplicationIcon"]; if not available, generic icon.

--@"Copyright": NSString containing the copyright string. If not specified,
--obtain from the value of NSHumanReadableCopyright (localizable) in infoDictionary; if not available, leave blank.

--@"Version": NSString containing the build version number of the application
--("58.4", "1.2d3"); displayed as "Version 58.4" or "Version 1.0 (58.4) depending on the presence of ApplicationVersion. 
--If not specified, obtain from the CFBundleVersion key in infoDictionary; if not specified or empty string, leave blank.

--@"ApplicationVersion": NSString displayed as the marketing version  ("1.0", "Mac OS X", "3", "WebObjects 3.5", ...), before the build version.
--If not specified, obtain from CFBundleShortVersionString key in infoDictionary. Prefixed with word "Version" if it looks like a number.
--*/

feature -- Managing the Event Loop

--- (void)run;

	frozen run_modal_for_window (a_application: POINTER; a_window: POINTER): INTEGER
			-- - (NSInteger)runModalForWindow:(NSWindow *)theWindow
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSApplication*)$a_application runModalForWindow: $a_window];"
		end

	frozen abort_modal (a_application: POINTER)
			-- - (void)abortModal
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSApplication*)$a_application abortModal];"
		end

feature -- Handling Events

	frozen next_event (a_application : POINTER; matching_mask: INTEGER; until_date: POINTER; in_mode: INTEGER; dequeue: BOOLEAN): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					return [(NSApplication*)$a_application
								nextEventMatchingMask: NSAnyEventMask
								untilDate: [NSDate distantFuture]
								inMode: NSDefaultRunLoopMode
								dequeue: YES];
				}
			]"
		end

end
