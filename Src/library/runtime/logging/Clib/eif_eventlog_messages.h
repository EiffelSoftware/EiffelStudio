 // eif_messages.mc 
 // This is the header section.
 // The following are the categories of events.
//
//  Values are 32 bit values layed out as follows:
//
//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
//  +---+-+-+-----------------------+-------------------------------+
//  |Sev|C|R|     Facility          |               Code            |
//  +---+-+-+-----------------------+-------------------------------+
//
//  where
//
//      Sev - is the severity code
//
//          00 - Success
//          01 - Informational
//          10 - Warning
//          11 - Error
//
//      C - is the Customer code flag
//
//      R - is a reserved bit
//
//      Facility - is the facility code
//
//      Code - is the facility's status code
//
//
// Define the facility codes
//
#define FACILITY_APPLICATION             0x0


//
// Define the severity codes
//
#define STATUS_SEVERITY_WARNING          0x2
#define STATUS_SEVERITY_SUCCESS          0x0
#define STATUS_SEVERITY_INFORMATION      0x1
#define STATUS_SEVERITY_ERROR            0x3


//
// MessageId: EIF_LOGGING_EMERGENCY
//
// MessageText:
//
//  Emergency
//
#define EIF_LOGGING_EMERGENCY            ((WORD)0x00000001L)

//
// MessageId: EIF_LOGGING_ALERT
//
// MessageText:
//
//  Alert
//
#define EIF_LOGGING_ALERT                ((WORD)0x00000002L)

//
// MessageId: EIF_LOGGING_CRITICAL
//
// MessageText:
//
//  Critical
//
#define EIF_LOGGING_CRITICAL             ((WORD)0x00000003L)

//
// MessageId: EIF_LOGGING_ERROR
//
// MessageText:
//
//  Error
//
#define EIF_LOGGING_ERROR                ((WORD)0x00000004L)

//
// MessageId: EIF_LOGGING_WARNING
//
// MessageText:
//
//  Warning
//
#define EIF_LOGGING_WARNING              ((WORD)0x00000005L)

//
// MessageId: EIF_LOGGING_NOTICE
//
// MessageText:
//
//  Notice
//
#define EIF_LOGGING_NOTICE               ((WORD)0x00000006L)

//
// MessageId: EIF_LOGGING_INFORMATION
//
// MessageText:
//
//  Information
//
#define EIF_LOGGING_INFORMATION          ((WORD)0x00000007L)

//
// MessageId: EIF_LOGGING_DEBUG
//
// MessageText:
//
//  Debug
//
#define EIF_LOGGING_DEBUG                ((WORD)0x00000008L)

 // The following are the message definitions.
//
// MessageId: EIF_LOGGING_INFO_MESSAGE
//
// MessageText:
//
//  %1
//
#define EIF_LOGGING_INFO_MESSAGE         ((DWORD)0x40000100L)

//
// MessageId: EIF_LOGGING_WARN_MESSAGE
//
// MessageText:
//
//  %1
//
#define EIF_LOGGING_WARN_MESSAGE         ((DWORD)0x80000101L)

//
// MessageId: EIF_LOGGING_ERRO_MESSAGE
//
// MessageText:
//
//  %1
//
#define EIF_LOGGING_ERRO_MESSAGE         ((DWORD)0xC0000102L)

//
// MessageId: EIF_LOGGING_SUCC_MESSAGE
//
// MessageText:
//
//  %1
//
#define EIF_LOGGING_SUCC_MESSAGE         ((DWORD)0x00000103L)

