#ifndef GRAPHICS_STATICINDEXBUFFER_HPP__
#define GRAPHICS_STATICINDEXBUFFER_HPP__ 1

#include <graphics/indexbuffer.hpp>
#include <utils/databuffer.hpp>
#include <utils/ref.hpp>
#include <common.hpp>

namespace graphics
{
	R_CLASS( name = staticindexbuffer )
	class StaticIndexBuffer: public IndexBuffer
	{
	private:
		utils::Ref< utils::DataBuffer > m_data;

	protected:
		virtual void doadvance() override;

	public:
		StaticIndexBuffer( utils::DataBuffer* data );
		virtual ~StaticIndexBuffer() override;
		StaticIndexBuffer( StaticIndexBuffer const& ) = delete;
		StaticIndexBuffer& operator=( StaticIndexBuffer const& ) = delete;

		R_METHOD() static StaticIndexBuffer* create(
			utils::DataBuffer* data )
		{
			return new StaticIndexBuffer( data );
		}
	};
}

#endif
