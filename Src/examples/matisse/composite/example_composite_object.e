indexing
	description: "MATISSE-Eiffel Binding: Example of Composite Object";
	date: "$Date$";
	revision: "$Revision$"

class
	EXAMPLE_COMPOSITE_OBJECT

inherit
	MT_CONSTANTS
	
	ARGUMENTS
	
	
creation
	make
	
feature
	make is
		do
			if arg_number /= 3 then
				print_usage
			else
			!!mt_appl.set_login(argument(1), argument(2))
			mt_appl.connect
			create_data
			mt_appl.disconnect
			
			mt_appl.connect
			lock_composite_object
			delete_composite_object
			mt_appl.disconnect
			end
		end
	
	print_usage is
		do
			print("Usage:%N")
			print("	Specify arguments <hostname> and <database_name>%N")
			print("	Right-click on the Run button and type your host name and database name in this order%N")
		end

feature

	lock_composite_object is
		local
			entry: MT_ENTRYPOINT
			obj: DOCUMENT
			retried: BOOLEAN
			hoped, obtained: INTEGER
			another_appl: MATISSE_APPL
		do
			print("***** Locking a composite object 'Document Bar' *****%N")
			if not retried then
				print("Connection-1 established%N")
				mt_appl.set_no_current_connection
				
				!!another_appl.set_login(mt_appl.host_name, mt_appl.database_name)
				another_appl.set_wait(Mt_No_Wait)
				another_appl.connect
				print("Connection-2 established%N")
				
				mt_appl.start_transaction
				!!entry.make_from_name("title", "DOCUMENT")
				obj ?= entry.retrieve_first(Document_name)
				obj.lock_composite(Mt_Write)
				print("A composite object ")
				print(Document_name) 
				print(" is entirely write-locked in Connection-1%N")
				
				another_appl.start_transaction
				print("%NConnection-2 becomes the current connection%N")
				read_unlocked_object
				read_locked_object
				another_appl.commit_transaction
				mt_appl.commit_transaction
			end
		rescue
			mt_appl.abort_transaction
			retried := True
			retry
		end

	read_unlocked_object is
		local
			entry: MT_ENTRYPOINT
			obj: SECTION
			temp: STRING
		do
			print("reading the section 1.1 Foo in the Document Foo... ")
			!!entry.make_from_name("title", "SECTION")
			obj ?= entry.retrieve_first("1.1 Foo")
			temp := obj.get_title  -- This should not raise an exception
			print("done.%N")
		end

	read_locked_object is
		local
			entry: MT_ENTRYPOINT
			obj: SECTION
			retried: BOOLEAN
		do
			if not retried then
				print("reading the section 1.1 Bar in the Document Bar...%N")
				print("	This will raise an exception.%N")
				print("	Click the 'Run' button in the project window to continue%N")
				!!entry.make_from_name("title", "SECTION")
				obj ?= entry.retrieve_first("1.1 Bar")
				print(obj.get_title) -- This should raise an exception
			end
		rescue
			retried := True
			retry
		end
		
	delete_composite_object is
		local
			entry: MT_ENTRYPOINT
			a_class: MT_CLASS
			obj: DOCUMENT
			retried: BOOLEAN
			hoped, obtained: INTEGER
		do
			print("%N%N***** Deleting a composite object 'Document Bar' *****%N")
			if not retried then
				mt_appl.start_transaction
				
				print("---Before the deletion---%N")
				!!a_class.make_from_name("DOCUMENT")
				obtained := a_class.instances_count
				hoped := 2
				print("Number of instances of class DOCUMENT is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("DOC_AUTHOR")
				obtained := a_class.instances_count
				hoped := 2
				print("Number of instances of class DOC_AUTHOR is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("CHAPTER")
				obtained := a_class.instances_count
				hoped := 6
				print("Number of instances of class CHAPTER is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("SECTION")
				obtained := a_class.instances_count
				hoped := 12
				print("Number of instances of class SECTION is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("PARAGRAPH")
				obtained := a_class.instances_count
				hoped := 12
				print("Number of instances of class PARAGRAPH is ")
				print(obtained.out) io.new_line io.new_line
				
				---- Delete the composite object ----
				!!entry.make_from_name("title", "DOCUMENT")
				obj ?= entry.retrieve_first(Document_name)
				obj.mt_remove
				print(Document_name)
				print(" has just been removed. (a_document.mt_removed)%N")
				print("---After the deletion---%N")
				
				!!a_class.make_from_name("DOCUMENT")
				obtained := a_class.instances_count
				hoped := 1
				print("Number of instances of class DOCUMENT is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("DOC_AUTHOR")
				obtained := a_class.instances_count
				hoped := 2
				print("Number of instances of class DOC_AUTHOR is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("CHAPTER")
				obtained := a_class.instances_count
				hoped := 3
				print("Number of instances of class CHAPTER is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("SECTION")
				obtained := a_class.instances_count
				hoped := 6
				print("Number of instances of class SECTION is ")
				print(obtained.out) io.new_line
				
				!!a_class.make_from_name("PARAGRAPH")
				obtained := a_class.instances_count
				hoped := 6
				print("Number of instances of class PARAGRAPH is ")
				print(obtained.out) io.new_line
				
				mt_appl.commit_transaction
			end
		rescue
			mt_appl.abort_transaction
			retried := True
			retry
		end

feature {NONE} -- Implementation

	create_data is
		local
			a_class: MT_CLASS
			doc: DOCUMENT
			author: DOC_AUTHOR
			chap: CHAPTER
			section, linked_section: SECTION
			paragraph: PARAGRAPH
			i, j: INTEGER
			sec_name: STRING
		do
			mt_appl.start_transaction
			!!a_class.make_from_name("DOCUMENT")
			a_class.remove_all_instances
			
			!!a_class.make_from_name("DOC_AUTHOR")
			a_class.remove_all_instances
			
			!!doc
			current_db.persist(doc)
			doc.set_title("Document Foo")
			!!author.make("Author Foo")
			doc.get_authors.extend(author)
			from i := 1
			until i > 3
			loop
				!!chap.make(i.out)
				doc.get_chapters.extend(chap)
				from j := 1
				until j > 2
				loop
					sec_name := i.out
					sec_name.append(".")
					sec_name.append(j.out)
					sec_name.append(" Foo")					
					!!section.make(sec_name)
					chap.get_sections.extend(section)
					!!paragraph.make("text here ....")
					section.get_paragraphs.extend(paragraph)
					if i = 1 and j = 1 then
						linked_section := section
					end
					j := j + 1
				end
				i := i + 1
			end
			print("Document Foo is created%N")
			print("	It is written by the Author Foo.%N")
			print("	It consists of three chapters. Each chapter has two sections.%N")
			print("	Each section has one paragraph%N%N")
			
			!!doc
			current_db.persist(doc)
			doc.set_title(Document_name)
			!!author.make("Author Bar")
			doc.get_authors.extend(author)
			from i := 1
			until i > 3
			loop
				!!chap.make(i.out)
				doc.get_chapters.extend(chap)
				from j := 1
				until j > 2
				loop
					sec_name := i.out
					sec_name.append(".")
					sec_name.append(j.out)
					sec_name.append(" Bar")
					!!section.make(sec_name)
					chap.get_sections.extend(section)
					!!paragraph.make("bar text here ....")
					section.get_paragraphs.extend(paragraph)
					if i = 3 and j = 1 then
						paragraph.get_hyperlinks.extend(linked_section)
					end
					j := j + 1
				end
				i := i + 1
			end
			print(Document_name)
			print(" is created%N")
			print("	It is written by the Author Bar.%N")
			print("	It consists of three chapters. Each chapter has two sections.%N")
			print("	Each section has one paragraph%N%N")
			mt_appl.commit_transaction
		end

feature
	Document_name : STRING is "Document Bar"

feature
	mt_appl: MATISSE_APPL		

end -- class TEST_COMPOSITE_OBJECT
