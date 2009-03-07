To generate the IDL file for using the .NET consumer as a .NET component. Use:

  tlbexp /oldnames EiffelSoftware.MetadataConsumer.dll

Then do

  oleview EiffelSoftware.MetadataConsumer.tlb

Get the IDL content and remove the following entries in the IDL:
    importlib("mscorlib.tlb");
	custom(...)
    interface _Object;
    interface ISponsor;

Then compare with the previous version of the IDL to ensure it corresponds to your changes.
