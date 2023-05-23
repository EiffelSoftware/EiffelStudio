public class Program
{
  // A private field name
  private string name;

  // A public property Name with get and set accessors
  public string Name
  {
    get { return name; }
    set { name = value; }
  }

  public static void Main() => Console.WriteLine("Hello\0");
}
