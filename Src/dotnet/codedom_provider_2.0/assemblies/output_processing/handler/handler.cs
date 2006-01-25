using System;

namespace EiffelSoftware.Compiler
{
	/// <summary>
	/// Compiler output handler interface, should be implemented
	/// by types willing to handle Eiffel compiler outputs.
	/// </summary>
	public interface IOutputHandler
	{
		void ProcessOutput (string output);
		void ProcessError (string fullError, string shortError, string code, string fileName, int line, int col);
	}
}
