-- target:
--   client-main
--   renderer-d3d9
--   renderer-gles
return {
	{
		type = 'native',
		name = 'common',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'osapi',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'reflection',
		headeronly = true,
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'common/databuffer',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'common/flaglock',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'common/mpsclist',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'common/mpscqueue',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'common/ref',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'common/refobject',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'common/stringbuilder',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'common/task',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'utils/cbase',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'utils/configset',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'utils/console',
		target = 'client-main',
	},
	{
		type = 'native',
		name = 'utils/encoding',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'utils/path',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'utils/pathparse',
		headeronly = true,
		target = 'client-main',
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'rsbin/common',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'rsbin/filestorage',
		target = 'client-main',
		reflect = true,
	},
	-- {
		-- type = 'native',
		-- name = 'rsbin/flaccommon',
		-- headeronly = true,
		-- target = 'client-main',
		-- reflect = true,
	-- },
	-- {
		-- type = 'native',
		-- name = 'rsbin/flacreader',
		-- target = 'client-main',
		-- reflect = true,
	-- },
	-- {
		-- type = 'native',
		-- name = 'rsbin/flacwriter',
		-- target = 'client-main',
		-- reflect = true,
	-- },
	-- {
		-- type = 'native',
		-- name = 'rsbin/fsthread',
		-- target = 'client-main',
	-- },
	-- {
		-- type = 'native',
		-- name = 'rsbin/iotask',
		-- headeronly = true,
		-- target = 'client-main',
		-- reflect = true,
	-- },
	{
		type = 'native',
		name = 'rsbin/memorystorage',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'rsbin/pngcommon',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'rsbin/pngreader',
		target = 'client-main',
		reflect = true,
	},
	-- {
		-- type = 'native',
		-- name = 'rsbin/pngwriter',
		-- target = 'client-main',
		-- reflect = true,
	-- },
	{
		type = 'native',
		name = 'rsbin/storage',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'rsbin/storagestream',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'rsbin/stream',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'renderer-state/common',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/context',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/context-cpp',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/interface',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/interface-cpp',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
		-- reflect = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-cpp',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-base',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-functions',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-generators',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-shaders',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-state',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-step',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/programtranslator-swizzles',
		-- use = 'renderer-d3d9;renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-state/resource',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
		-- reflect = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/resource-cpp',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/shape',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
		-- reflect = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/shape-cpp',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/shapegroup',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
		-- reflect = 'renderer-d3d9;renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-state/shapegroup-cpp',
		headeronly = true,
		-- use = 'renderer-d3d9;renderer-gles',
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'renderer-d3d9/clearshape',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/common',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/context',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/display',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/interface',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/primitiveshape',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/program',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/programtranslator',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/resource',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/shape',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/shapegroup',
		use = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/staticvertexbuffer',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/vertexbuffer',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
	{
		type = 'native',
		name = 'renderer-d3d9/vertexdeclaration',
		use = 'renderer-d3d9',
		reflect = 'renderer-d3d9',
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'renderer-gles/clearshape',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/common',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/context',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/display',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/gl2',
		use = 'renderer-gles',
		headeronly = true,
	},
	{
		type = 'native',
		name = 'renderer-gles/interface',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/primitiveshape',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/program',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/programtranslator',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/resource',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/shape',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/shapegroup',
		use = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/staticvertexbuffer',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/vertexbuffer',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
	{
		type = 'native',
		name = 'renderer-gles/vertexdeclaration',
		use = 'renderer-gles',
		reflect = 'renderer-gles',
	},
--------------------------------------------------------------------------------
	{
		type = 'native',
		name = 'client-main/event',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'client-main/main',
		noheader = true,
		target = 'client-main',
	},
	{
		type = 'native',
		name = 'client-main/window',
		target = 'client-main',
		reflect = true,
	},
	{
		type = 'native',
		name = 'client-main/windowinfo',
		headeronly = true,
		target = 'client-main',
		reflect = true,
	},
}
