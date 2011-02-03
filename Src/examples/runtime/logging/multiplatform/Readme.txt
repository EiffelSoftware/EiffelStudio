This example show the use of the logging cluster on Windows. It writes messages
to the Application Event Log under the Event Source name EifSysLog.

It is required that you include that Event Source in the Registry as described
in the documentation for the logging library. Failure to do so will result in
Event Viewer warnings that the source for the message cannot be found.
