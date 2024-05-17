#ifndef __CLI_CORDEBUG_H_
#define __CLI_CORDEBUG_H_

#include <cor.h>
#include <cordebug.h>

#ifdef _cplusplus
extern "C" {
#endif

/**********************/
/* IID_ .. constants  */
/**********************/

extern const CLSID CLSID_CorDebug;
//extern const CLSID CLSID_EmbeddedCLRCorDebug;
//extern const IID IID_ICorDebugManagedCallback;
//extern const IID IID_ICorDebugUnmanagedCallback;
extern const IID IID_ICorDebug;
//extern const IID IID_ICorDebug2;

extern const IID IID_ICorDebugController;
//extern const IID IID_ICorDebugAppDomain;
//extern const IID IID_ICorDebugAssembly;
//extern const IID IID_ICorDebugProcess;
//extern const IID IID_ICorDebugBreakpoint;
extern const IID IID_ICorDebugFunctionBreakpoint;
extern const IID IID_ICorDebugModuleBreakpoint;
extern const IID IID_ICorDebugValueBreakpoint;
//extern const IID IID_ICorDebugStepper;
//extern const IID IID_ICorDebugRegisterSet;
//extern const IID IID_ICorDebugThread;
//extern const IID IID_ICorDebugChain;
//extern const IID IID_ICorDebugFrame;
extern const IID IID_ICorDebugILFrame;
extern const IID IID_ICorDebugNativeFrame;
//extern const IID IID_ICorDebugModule;
//extern const IID IID_ICorDebugFunction;
//extern const IID IID_ICorDebugCode;
//extern const IID IID_ICorDebugClass;
//extern const IID IID_ICorDebugEval;
//extern const IID IID_ICorDebugValue;
extern const IID IID_ICorDebugGenericValue;
extern const IID IID_ICorDebugReferenceValue;
extern const IID IID_ICorDebugHeapValue;
extern const IID IID_ICorDebugObjectValue;
extern const IID IID_ICorDebugBoxValue;
extern const IID IID_ICorDebugStringValue;
extern const IID IID_ICorDebugArrayValue;
//extern const IID IID_ICorDebugContext;
//extern const IID IID_ICorDebugEnum;
//extern const IID IID_ICorDebugObjectEnum;
//extern const IID IID_ICorDebugBreakpointEnum;
//extern const IID IID_ICorDebugStepperEnum;
//extern const IID IID_ICorDebugProcessEnum;
//extern const IID IID_ICorDebugThreadEnum;
//extern const IID IID_ICorDebugFrameEnum;
//extern const IID IID_ICorDebugChainEnum;
//extern const IID IID_ICorDebugModuleEnum;
//extern const IID IID_ICorDebugValueEnum;
//extern const IID IID_ICorDebugErrorInfoEnum;
//extern const IID IID_ICorDebugAppDomainEnum;
//extern const IID IID_ICorDebugAssemblyEnum;
//extern const IID IID_ICorDebugEditAndContinueErrorInfo;
//extern const IID IID_ICorDebugEditAndContinueSnapshot;

#ifdef _cplusplus
}
#endif

#endif // __CLI_CORDEBUG_H_
