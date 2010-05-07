#!/usr/bin/ruby

require "schema.rb"

# generate header
def generateHeader(cdef, fh)
    fh.puts "//"
end

def generateImplementation(cdef, fh)
    fh.puts "//"
end

# start from here
schema = Schema.new
schema.loadFromFile("schema.def")
schema.dump

# generate
schema.defs.each do |cdef|
    fh = open(cdef.name + ".h", "w")
    generateHeader(cdef, fh)
    fh.close

    fh = open(cdef.name + ".m", "w")
    generateImplementation(cdef, fh)
    fh.close
end

        
    
