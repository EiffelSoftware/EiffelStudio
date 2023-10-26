// See https://aka.ms/new-console-template for more information
using Eiffel.MD.Testing;

Console.WriteLine("Testing .NET generics!");

Bar bar = new Bar(123);
Console.WriteLine(bar.bargen<Object>("test-gen-object"));
Console.WriteLine(bar.bargen<string>("test-gen-string"));
Console.WriteLine(bar.bargen<string>("test-gen-string-bis"));
Console.WriteLine(bar.bargen<int>(123));

