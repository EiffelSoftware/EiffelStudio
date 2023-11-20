// See https://aka.ms/new-console-template for more information
using Eiffel.MD.Testing;

Console.WriteLine("Testing .NET generics!");

Bar bar = new Bar(123);
Console.WriteLine(bar.bargen_t<Object>("test-gen-object"));
Console.WriteLine(bar.bargen_t<string>("test-gen-string"));
Console.WriteLine(bar.bargen_t<string>("test-gen-string-bis"));
Console.WriteLine(bar.bargen_t<int>(456));
Console.WriteLine(bar.bargen_tu<int, string>(333, "arg2"));
Console.WriteLine(bar.bargen_tu<Object, Object>(444, "arg2"));
string? str;
str = bar.bargen_t_str_u<int, string>(111, "string", "arg3");
str = bar.bargen_rt_t<string>("string-value");

Console.WriteLine(bar.barnogen("FooBar"));

