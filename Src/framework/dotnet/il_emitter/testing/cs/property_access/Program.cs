using System;

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

    public static void Main()
    {
        Program program = new Program();

        // Set the Name property
        program.Name = "John Doe";

        // Get the Name property and output it to the console
        Console.WriteLine("Name: " + program.Name);
    }
}
