; // eif_messages.mc 

; // This is the header section.


SeverityNames=(Success=0x0:STATUS_SEVERITY_SUCCESS
               Information=0x1:STATUS_SEVERITY_INFORMATION
               Warning=0x2:STATUS_SEVERITY_WARNING
               Error=0x3:STATUS_SEVERITY_ERROR
              )


FacilityNames=(Application=0x0:FACILITY_APPLICATION)

LanguageNames=(English=0x409:MSG00409)


; // The following are the categories of events.

MessageIdTypedef=WORD

MessageId=0x1
SymbolicName=EIF_LOGGING_EMERGENCY
Language=English
Emergency
.

MessageId=0x2
SymbolicName=EIF_LOGGING_ALERT
Language=English
Alert
.

MessageId=0x3
SymbolicName=EIF_LOGGING_CRITICAL
Language=English
Critical
.

MessageId=0x4
SymbolicName=EIF_LOGGING_ERROR
Language=English
Error
.

MessageId=0x5
SymbolicName=EIF_LOGGING_WARNING
Language=English
Warning
.

MessageId=0x6
SymbolicName=EIF_LOGGING_NOTICE
Language=English
Notice
.

MessageId=0x7
SymbolicName=EIF_LOGGING_INFORMATION
Language=English
Information
.

MessageId=0x8
SymbolicName=EIF_LOGGING_DEBUG
Language=English
Debug
.


; // The following are the message definitions.

MessageIdTypedef=DWORD

MessageId=0x100
Severity=Information
Facility=Application
SymbolicName=EIF_LOGGING_INFO_MESSAGE
Language=English
%1
.

MessageId=0x101
Severity=Warning
Facility=Application
SymbolicName=EIF_LOGGING_WARN_MESSAGE
Language=English
%1
.

MessageId=0x102
Severity=Error
Facility=Application
SymbolicName=EIF_LOGGING_ERRO_MESSAGE
Language=English
%1
.

MessageId=0x103
Severity=Success
Facility=Application
SymbolicName=EIF_LOGGING_SUCC_MESSAGE
Language=English
%1
.

