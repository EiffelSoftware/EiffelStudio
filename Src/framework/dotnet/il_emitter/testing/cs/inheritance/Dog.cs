interface IAnimal
{
    void MakeSound();
}

interface IDog : IAnimal
{
    void Fetch();
}


public class Dog : IDog
{
    public void MakeSound()
    {
        Console.WriteLine("Woof!");
    }
    public void Fetch()
    {
        Console.WriteLine("Fetching!");
    }

    public static void Main()
    {
        Dog pluto = new Dog();
        pluto.MakeSound();

    }
}
