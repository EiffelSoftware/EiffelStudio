using System;

 public class Program
    {
        public void F1(int i)
        {
            Console.WriteLine(i);
        }

        public void F2(string str, int i)
        {
            Console.WriteLine(str);
            Console.WriteLine(i);
        }

        public void F3(string str, int i, string str2)
        {
            Console.WriteLine(str);
            Console.WriteLine(i);
            Console.WriteLine(str2);

        }


    static void Main()
        {
            Program myProgram = new Program();
            Console.WriteLine("Function F1");
            myProgram.F1(10);
            Console.WriteLine("Function F2");
            myProgram.F2("Hello", 11);
            Console.WriteLine("Function F3");
            myProgram.F3("Hello", 12, "World");
        }
 }
