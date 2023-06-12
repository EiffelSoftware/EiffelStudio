using System;

// Define an interface
interface IPrintable
{
    void Print();
}
interface IMark
{

}

public class Program : IPrintable, IMark
{

    // Implement the Print method from the IPrintable interface
    public void Print()
    {
        Console.WriteLine("Testing Basic Interfaces");
    }

    public static void Main()
    {
        Program program = new Program();

        // Call the Print method to output the console
        program.Print();
    }
}
