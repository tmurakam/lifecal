#!/usr/bin/ruby

class ClassDef
    attr_accessor :name, :members, :types

    def initialize
        @name = nil
        @members = Array.new
        @types = Hash.new
    end

    def dump
        puts "-- #{@name} --"
        @members.each do |member|
            puts "  #{@types[member]}: #{member}"
        end
    end
end

class Schema
    attr_reader :defs

    def initialize
        @defs = Array.new
    end

    def loadFromFile(filename)
        open(filename) do |fh|
            
            classdef = nil

            fh.each do |line|
                line.chop!
                
                if (line =~ /^(\S+)/)
                    if (classdef != nil)
                        @defs.push(classdef)
                    end
                    classdef = ClassDef.new
                    classdef.name = $1
                elsif (line =~ /\s+(\S+):\s*(\S+)/)
                    member = $2
                    type = $1
                    classdef.members.push(member)
                    classdef.types[member] = type
                end
            end
            if (classdef != nil)
                @defs.push(classdef)
            end
        end
    end

    def dump
        @defs.each do |classdef|
            classdef.dump
        end
    end
end

        
