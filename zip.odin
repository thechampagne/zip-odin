package zip

SHARED :: #config(SHARED, false)
LOCAL :: #config(LOCAL, false)

when ODIN_OS == .Windows  {
    when SHARED {
        when LOCAL {
            foreign import lib "zip.dll" 
	} else {
            foreign import lib "system:zip.dll"
	}
    } else {
	when LOCAL {
            foreign import lib "zip.lib"
	} else {
            foreign import lib "system:zip.lib"
	}
    }
} else when ODIN_OS == .Darwin {
    when SHARED {
        when LOCAL {
            foreign import lib "libzip.dylib" 
	} else {
            foreign import lib "system:libzip.dylib"
	}
    } else {
	when LOCAL {
            foreign import lib "libzip.a"
	} else {
            foreign import lib "system:libzip.a"
	}
    }
} else when ODIN_OS == .Linux {
    when SHARED {
        when LOCAL {
            foreign import lib "libzip.so" 
	} else {
            foreign import lib "system:libzip.so"
	}
    } else {
	when LOCAL {
            foreign import lib "libzip.a"
	} else {
            foreign import lib "system:libzip.a"
	}
    }
} else {
    foreign import lib "system:zip"
}

import "core:c"

DEFAULT_COMPRESSION_LEVEL :: 6
ENOINIT :: -1
EINVENTNAME :: -2
ENOENT :: -3
EINVMODE :: -4
EINVLVL :: -5
ENOSUP64 :: -6
EMEMSET :: -7
EWRTENT :: -8
ETDEFLINIT :: -9
EINVIDX :: -10
ENOHDR :: -11
ETDEFLBUF :: -12
ECRTHDR :: -13
EWRTHDR :: -14
EWRTDIR :: -15
EOPNFILE :: -16
EINVENTTYPE :: -17
EMEMNOALLOC :: -18
ENOFILE :: -19
ENOPERM :: -20
EOOMEM :: -21
EINVZIPNAME :: -22
EMKDIR :: -23
ESYMLINK :: -24
ECLSZIP :: -25
ECAPSIZE :: -26
EFSEEK :: -27
EFREAD :: -28
EFWRITE :: -29
ERINIT :: -30
EWINIT :: -31
EWRINIT :: -32

Zip :: rawptr

@(default_calling_convention="c")
foreign lib {

    @(link_name="zip_strerror")
    strerror :: proc(errnum : c.int) -> cstring ---

    @(link_name="zip_open")
    open :: proc(zipname : cstring, level : c.int, mode : c.char) -> Zip ---

    @(link_name="zip_openwitherror")
    openwitherror :: proc(zipname : cstring, level : c.int, mode : c.char, errnum : ^c.int) -> Zip ---

    @(link_name="zip_close")
    close :: proc(zip : Zip) ---

    @(link_name="zip_is64")
    is64 :: proc(zip : Zip) -> c.int ---

    @(link_name="zip_entry_open")
    entry_open :: proc(zip : Zip, entryname : cstring) -> c.int ---

    @(link_name="zip_entry_opencasesensitive")
    entry_opencasesensitive :: proc(zip : Zip, entryname : cstring) -> c.int ---

    @(link_name="zip_entry_openbyindex")
    entry_openbyindex :: proc(zip : Zip, index : c.size_t) -> c.int ---

    @(link_name="zip_entry_close")
    entry_close :: proc(zip : Zip) -> c.int ---

    @(link_name="zip_entry_name")
    entry_name :: proc(zip : Zip) -> cstring ---

    @(link_name="zip_entry_index")
    entry_index :: proc(zip : Zip) -> c.size_t ---

    @(link_name="zip_entry_isdir")
    entry_isdir :: proc(zip : Zip) -> c.int ---

    @(link_name="zip_entry_size")
    entry_size :: proc(zip : Zip) -> c.ulonglong ---

    @(link_name="zip_entry_uncomp_size")
    entry_uncomp_size :: proc(zip : Zip) -> c.ulonglong ---

    @(link_name="zip_entry_comp_size")
    entry_comp_size :: proc(zip : Zip) -> c.ulonglong ---

    @(link_name="zip_entry_crc32")
    entry_crc32 :: proc(zip : Zip) -> c.uint ---

    @(link_name="zip_entry_write")
    entry_write :: proc(zip : Zip, buf : rawptr, bufsize : c.size_t) -> c.int ---

    @(link_name="zip_entry_fwrite")
    entry_fwrite :: proc(zip : Zip, filename : cstring) -> c.int ---

    @(link_name="zip_entry_read")
    entry_read :: proc(zip : Zip, buf : ^rawptr, bufsize : ^c.size_t) -> c.size_t ---

    @(link_name="zip_entry_noallocread")
    entry_noallocread :: proc(zip : Zip, buf : rawptr, bufsize : c.size_t) -> c.size_t ---

    @(link_name="zip_entry_fread")
    entry_fread :: proc(zip : Zip, filename : cstring) -> c.int ---

    @(link_name="zip_entry_extract")
    entry_extract :: proc(zip : Zip, fun : #type proc(arg : rawptr, offset : u64, data : rawptr, size : c.size_t) -> c.size_t, arg : rawptr) -> c.int ---

    @(link_name="zip_entries_total")
    entries_total :: proc(zip : Zip) -> c.size_t ---

    @(link_name="zip_entries_delete")
    entries_delete :: proc(zip : Zip, entries : ^cstring, len : c.size_t) -> c.size_t ---

    @(link_name="zip_stream_extract")
    stream_extract :: proc(stream : cstring, size : c.size_t, dir : cstring, fun : #type proc(filename : cstring, arg : rawptr) -> c.int, arg : rawptr) -> c.int ---

    @(link_name="zip_stream_open")
    stream_open :: proc(stream : cstring, size : c.size_t, level : c.int, mode : c.char) -> Zip ---

    @(link_name="zip_stream_openwitherror")
    stream_openwitherror :: proc(stream : cstring, size : c.size_t, level : c.int, mode : c.char, errnum : ^c.int) -> Zip ---

    @(link_name="zip_stream_copy")
    stream_copy :: proc(zip : Zip, buf : ^rawptr, bufsize : ^c.size_t) -> c.size_t ---

    @(link_name="zip_stream_close")
    stream_close :: proc(zip : Zip) ---

    @(link_name="zip_create")
    create :: proc(zipname : cstring, filenames : ^cstring, len : c.size_t) -> c.int ---

    @(link_name="zip_extract")
    extract :: proc(zipname : cstring, dir : cstring, fun : #type proc(filename : cstring, arg : rawptr) -> c.int, arg : rawptr) -> c.int ---
}
