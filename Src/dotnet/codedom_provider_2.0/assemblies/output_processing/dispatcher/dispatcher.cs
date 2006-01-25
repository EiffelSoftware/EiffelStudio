using System;
using EiffelSoftware.Compiler;

namespace EiffelSoftware.Compiler
{
	/// <summary>
	/// Compiler output dispatcher, allows adding output handlers that
	/// will process compiler's output.
	/// </summary>
	public class OutputDispatcher
	{
		static public void AddHandler (CEiffelCompiler compiler, IOutputHandler handler)
		{
			if (compiler != null && handler != null)
			{
				compiler.OutputError += new IEiffelCompilerEvents_OutputErrorEventHandler (handler.ProcessError);
				compiler.OutputString += new IEiffelCompilerEvents_OutputStringEventHandler (handler.ProcessOutput);
			}
		}
	}
}
