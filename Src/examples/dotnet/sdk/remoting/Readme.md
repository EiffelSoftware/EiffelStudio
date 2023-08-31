NetRemoting has been removed from .NetCore

.NET remoting is a legacy technology. It allows instantiating an object in another process (potentially even on a different machine) and interacting with that object as if it were an ordinary, in-process .NET object instance. The .NET remoting infrastructure only exists in .NET Framework 2.x - 4.x. .NET Core and .NET 5 and later versions don't have support for .NET remoting, and the remoting APIs either don't exist or always throw exceptions on these runtimes.

To help steer developers away from these APIs, we are obsoleting selected remoting-related APIs. These APIs may be removed entirely in a future version of .NET.

https://learn.microsoft.com/en-us/dotnet/core/compatibility/core-libraries/5.0/remoting-apis-obsolete


