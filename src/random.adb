with GNAT.OS_Lib;

with Ada.Text_IO;
with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package body Random is

   type Operating_System_Types is
     (Unix,
      DOS,
      Unknown);

   Operating_System : constant Operating_System_Types := (if GNAT.OS_Lib.Directory_Separator = '/' then Unix elsif GNAT.OS_Lib.Directory_Separator = '\' then DOS else Unknown);

   procedure Fill (Data : out String) is
   begin
      case Operating_System is
         when Unix =>
            declare

               F : File_Type;

            begin
               Open (F, In_File, "/dev/random");
               String'Read (Stream (F), Data);
               Close (F);
            end;

         when DOS =>
            raise Program_Error with "Windows";

         when others =>
            raise Program_Error with "Unknown";
      end case;
   end Fill;

end Random;
