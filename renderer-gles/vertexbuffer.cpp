#include <renderer-gles/vertexbuffer.hpp>
#include <renderer-gles/context.hpp>
#include <renderer-gles/common.hpp>

namespace graphics
{
	void VertexBuffer::doadvance()
	{
		VertexDeclaration* vd = m_vertexdeclaration;
		if( vd )
		{
			vd->advance();
		}
	}

	VertexBuffer::VertexBuffer()
		: m_vertexdeclaration( nullptr )
		, m_vertexbuffer( 0 )
		, m_buffercapacity( 0 )
		, m_buffersize( 0 )
	{
	}

	VertexBuffer::~VertexBuffer()
	{
		if( m_vertexbuffer )
		{
			glDeleteBuffers( 1, &m_vertexbuffer );
		}
	}

	bool VertexBuffer::bind( size_t* vertexcount, VertexDeclaration** pvd )
	{
		VertexDeclaration* vd = m_vertexdeclaration;
		if( !vd || !m_vertexbuffer )
		{
			return false;
		}
		if( Context::CurrentVertexBuffer != this )
		{
			glBindBuffer( GL_ARRAY_BUFFER, m_vertexbuffer );
			checkerror();
			Context::CurrentVertexBuffer = this;
		}
		size_t vertexsize;
		if( !vd->bind( &vertexsize ) )
		{
			return false;
		}
		*vertexcount = m_buffersize / vertexsize;
		*pvd = vd;
		return true;
	}
}
