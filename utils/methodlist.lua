local ml = ...
utils_databuffer
utils_encoding_t
utils_translation_t
utils_refobject

typedef struct
{
	bool(*utils_cbase_geterror)(char const** result);
	bool(*utils_cbase_seterror)(char const* error);
	bool(*utils_cbase_yield)();
	bool(*utils_cbase_write)(char const* str);
	bool(*utils_cbase_getchar)(char* str);
	bool(*utils_databuffer_new)(int length, int capacity, void const* data, utils_databuffer** result);
	bool(*utils_databuffer_getdata)(utils_databuffer* self, void** result);
	bool(*utils_databuffer_getlength)(utils_databuffer* self, int* result);
	bool(*utils_databuffer_setlength)(utils_databuffer* self, int length);
	bool(*utils_databuffer_getcapacity)(utils_databuffer* self, int* result);
	bool(*utils_getencoding)(int index, utils_encoding_t const** result);
	bool(*utils_translatestr)(utils_translation_t* translation, int* result);
	bool(*utils_refobject_addref)(utils_refobject const* self, int* result);
	bool(*utils_refobject_release)(utils_refobject const* self, int* result);
}
	utils_methodlist_t;
