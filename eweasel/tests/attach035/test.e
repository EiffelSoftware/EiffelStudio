class
   TEST
 
inherit
   ARGUMENTS
 
create
   make
 
feature {NONE} -- Initialization
 
   make is
         -- Run application.
      require
         x: {lt_ms: STRING}m_s
      do
      end
 
   m_s: STRING
 
end