public class EmitterSupport
{
	public static STRING ToReflectionString (string str)
	{
		STRING tempStr = new Implementation.STRING();
		tempStr.make_from_cil (str);
		return tempStr;
	}
	
	public static string FromReflectionString (STRING str)
	{
		return str.to_cil();
	}
}