# WARNING: This file was generated from fasta.rl using ragel. Do not edit!
# FASTA sequence types

immutable FASTA <: FileFormat end


"Metadata for FASTA sequence records containing just a `description` field"
type FASTAMetadata
    description::String

    function FASTAMetadata(description)
        return new(description)
    end

    function FASTAMetadata()
        return new("")
    end
end


"FASTASeqRecord{S} is a `SeqRecord` for FASTA sequences of type `S`"
typealias FASTASeqRecord{S}       SeqRecord{S, FASTAMetadata}

"A `SeqRecord` type for FASTA DNA sequences"
typealias FASTADNASeqRecord       DNASeqRecord{FASTAMetadata}

"A `SeqRecord` type for FASTA RNA sequences"
typealias FASTARNASeqRecord       RNASeqRecord{FASTAMetadata}

"A `SeqRecord` type for FASTA amino acid sequences"
typealias FASTAAminoAcidSeqRecord AminoAcidSeqRecord{FASTAMetadata}


function Base.show(io::IO, seqrec::FASTASeqRecord)
    write(io, ">", seqrec.name, " ", seqrec.metadata.description, "\n")
    show(io, seqrec.seq)
end


module FASTAParserImpl

import Bio.Seq: FASTASeqRecord
import Bio.Ragel
using Switch
export FASTAParser


const fasta_start  = convert(Int , 6)
const fasta_first_final  = convert(Int , 6)
const fasta_error  = convert(Int , 0)
const fasta_en_main  = convert(Int , 6)
"A type encapsulating the current state of a FASTA parser"
type FASTAParser
    state::Ragel.State
    seqbuf::Ragel.Buffer
    namebuf::String
    descbuf::String

    function FASTAParser(input::Union(IO, String, Vector{Uint8});
                         memory_map::Bool=false)
        cs = fasta_start;
	if memory_map
            if !isa(input, String)
                error("Parser must be given a file name in order to memory map.")
            end
            return new(Ragel.State(cs, input, true),
                       Ragel.Buffer{Uint8}(), "", "")
        else
            return new(Ragel.State(cs, input), Ragel.Buffer{Uint8}(), "", "")
        end
    end
end


function Ragel.ragelstate(parser::FASTAParser)
    return parser.state
end


function accept_state!{S}(input::FASTAParser, output::FASTASeqRecord{S})
    output.name = input.namebuf
    output.metadata.description = input.descbuf
    output.seq = S(input.seqbuf.data, 1, input.seqbuf.pos - 1)

    input.namebuf = ""
    input.descbuf = ""
    empty!(input.seqbuf)
end


Ragel.@generate_read_fuction("fasta", FASTAParser, FASTASeqRecord,
    begin
        @inbounds begin
            if p == pe
	@goto _test_eof

end
@switch cs  begin
    @case 6
@goto st_case_6
@case 0
@goto st_case_0
@case 1
@goto st_case_1
@case 2
@goto st_case_2
@case 3
@goto st_case_3
@case 4
@goto st_case_4
@case 7
@goto st_case_7
@case 8
@goto st_case_8
@case 5
@goto st_case_5

end
@goto st_out
@label ctr13
	input.state.linenum += 1
@goto st6
@label st6
p+= 1;
	if p == pe
	@goto _test_eof6

end
@label st_case_6
@switch ( data[1 + p ])  begin
    @case 9
@goto st6
@case 10
@goto ctr13
@case 32
@goto st6
@case 62
@goto st1

end
if 11 <= ( data[1 + p ]) && ( data[1 + p ]) <= 13
	@goto st6

end
@goto st0
@label st_case_0
@label st0
cs = 0;
	@goto _out
@label ctr17
	yield = true;
        	p+= 1; cs = 1; @goto _out



@goto st1
@label ctr21
	append!(input.seqbuf, state.buffer, (Ragel.@popmark!), p)
	yield = true;
        	p+= 1; cs = 1; @goto _out



@goto st1
@label st1
p+= 1;
	if p == pe
	@goto _test_eof1

end
@label st_case_1
if ( data[1 + p ]) == 32
	@goto st0

end
if ( data[1 + p ]) < 14
	if 9 <= ( data[1 + p ])
	@goto st0

end

elseif ( ( data[1 + p ]) > 31  )
	if 33 <= ( data[1 + p ])
	@goto ctr0

end

else
	@goto ctr0

end
@goto ctr0
@label ctr0
	Ragel.@pushmark!
@goto st2
@label st2
p+= 1;
	if p == pe
	@goto _test_eof2

end
@label st_case_2
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr3
@case 10
@goto ctr4
@case 11
@goto ctr3
@case 12
@goto st0
@case 13
@goto ctr5
@case 32
@goto ctr3

end
if ( data[1 + p ]) > 31
	if 33 <= ( data[1 + p ])
	@goto st2

end

elseif ( ( data[1 + p ]) >= 14  )
	@goto st2

end
@goto st2
@label ctr3
	input.namebuf = Ragel.@asciistring_from_mark!
@goto st3
@label st3
p+= 1;
	if p == pe
	@goto _test_eof3

end
@label st_case_3
@switch ( data[1 + p ])  begin
    @case 9
@goto st3
@case 10
@goto ctr6
@case 11
@goto st3
@case 32
@goto st3

end
if ( data[1 + p ]) > 31
	if 33 <= ( data[1 + p ])
	@goto ctr6

end

elseif ( ( data[1 + p ]) >= 12  )
	@goto ctr6

end
@goto ctr6
@label ctr6
	Ragel.@pushmark!
@goto st4
@label st4
p+= 1;
	if p == pe
	@goto _test_eof4

end
@label st_case_4
@switch ( data[1 + p ])  begin
    @case 10
@goto ctr9
@case 13
@goto ctr10

end
if ( data[1 + p ]) > 12
	if 14 <= ( data[1 + p ])
	@goto st4

end

elseif ( ( data[1 + p ]) >= 11  )
	@goto st4

end
@goto st4
@label ctr4
	input.namebuf = Ragel.@asciistring_from_mark!
	input.state.linenum += 1
@goto st7
@label ctr9
	input.descbuf = Ragel.@asciistring_from_mark!
	input.state.linenum += 1
@goto st7
@label ctr11
	input.state.linenum += 1
@goto st7
@label ctr19
	append!(input.seqbuf, state.buffer, (Ragel.@popmark!), p)
@goto st7
@label ctr20
	append!(input.seqbuf, state.buffer, (Ragel.@popmark!), p)
	input.state.linenum += 1
@goto st7
@label st7
p+= 1;
	if p == pe
	@goto _test_eof7

end
@label st_case_7
@switch ( data[1 + p ])  begin
    @case 9
@goto st7
@case 10
@goto ctr11
@case 32
@goto st7
@case 62
@goto ctr17

end
if ( data[1 + p ]) < 14
	if 11 <= ( data[1 + p ])
	@goto st7

end

elseif ( ( data[1 + p ]) > 31  )
	if ( data[1 + p ]) > 61
	if 63 <= ( data[1 + p ])
	@goto ctr15

end

elseif ( ( data[1 + p ]) >= 33  )
	@goto ctr15

end

else
	@goto ctr15

end
@goto ctr15
@label ctr15
	Ragel.@pushmark!
@goto st8
@label st8
p+= 1;
	if p == pe
	@goto _test_eof8

end
@label st_case_8
@switch ( data[1 + p ])  begin
    @case 9
@goto ctr19
@case 10
@goto ctr20
@case 32
@goto ctr19
@case 62
@goto ctr21

end
if ( data[1 + p ]) < 14
	if 11 <= ( data[1 + p ])
	@goto ctr19

end

elseif ( ( data[1 + p ]) > 31  )
	if ( data[1 + p ]) > 61
	if 63 <= ( data[1 + p ])
	@goto st8

end

elseif ( ( data[1 + p ]) >= 33  )
	@goto st8

end

else
	@goto st8

end
@goto st8
@label ctr5
	input.namebuf = Ragel.@asciistring_from_mark!
@goto st5
@label ctr10
	input.descbuf = Ragel.@asciistring_from_mark!
@goto st5
@label st5
p+= 1;
	if p == pe
	@goto _test_eof5

end
@label st_case_5
if ( data[1 + p ]) == 10
	@goto ctr11

end
@goto st0
@label st_out
@label _test_eof6
cs = 6; @goto _test_eof
@label _test_eof1
cs = 1; @goto _test_eof
@label _test_eof2
cs = 2; @goto _test_eof
@label _test_eof3
cs = 3; @goto _test_eof
@label _test_eof4
cs = 4; @goto _test_eof
@label _test_eof7
cs = 7; @goto _test_eof
@label _test_eof8
cs = 8; @goto _test_eof
@label _test_eof5
cs = 5; @goto _test_eof
@label _test_eof
if p == eof
	@switch cs  begin
    @case 7
	yield = true;
        	p+= 1; cs = 0; @goto _out




	break;
	@case 8
	append!(input.seqbuf, state.buffer, (Ragel.@popmark!), p)
	yield = true;
        	p+= 1; cs = 0; @goto _out




	break;

end

end
@label _out
end
    end,
    begin
        accept_state!(input, output)
    end)

end # module FASTAParserImpl


using Bio.Seq.FASTAParserImpl


"An iterator over entries in a FASTA file or stream."
type FASTAIterator
    parser::FASTAParser

    # A type or function used to construct output sequence types
    default_alphabet::Alphabet
    isdone::Bool
    nextitem
end

"""
Parse a FASTA file.

# Arguments
  * `filename::String`: Path of the FASTA file.
  * `alphabet::Alphabet`: Assumed alphabet for the sequences contained in the
      file. (Default: `DNA_ALPHABET`)
  * `memory_map::Bool`: If true, attempt to memory map the file on supported
    platforms. (Default: `false`)

# Returns
An iterator over `SeqRecord`s contained in the file.
"""
function Base.read(filename::String, ::Type{FASTA},
                   alphabet::Alphabet=DNA_ALPHABET; memory_map::Bool=false)
    return FASTAIterator(FASTAParser(filename, memory_map=memory_map),
                         alphabet, false, nothing)
end


"""
Parse a FASTA file.

# Arguments
  * `input::IO`: Input stream containing FASTA data.
  * `alphabet::Alphabet`: Assumed alphabet for the sequences contained in the
      file. (Default: DNA_ALPHABET)

# Returns
An iterator over `SeqRecord`s contained in the file.
"""
function Base.read(input::IO, ::Type{FASTA}, alphabet::Alphabet=DNA_ALPHABET)
    return FASTAIterator(FASTAParser(input), alphabet, false, nothing)
end


function Base.read(input::Cmd, ::Type{FASTA}, alphabet::Alphabet=DNA_ALPHABET)
    return FASTAIterator(FASTAParser(open(input, "r")[1]), alphabet, false, nothing)
end


function advance!(it::FASTAIterator)
    it.isdone = !FASTAParserImpl.advance!(it.parser)
    if !it.isdone
        alphabet = infer_alphabet(it.parser.seqbuf.data, 1, it.parser.seqbuf.pos - 1,
                                  it.default_alphabet)
        S = alphabet_type[alphabet]
        it.default_alphabet = alphabet
        it.nextitem =
            FASTASeqRecord{S}(it.parser.namebuf,
                              S(it.parser.seqbuf.data, 1, it.parser.seqbuf.pos - 1, true),
                              FASTAMetadata(it.parser.descbuf))
        empty!(it.parser.seqbuf)
    end
end


function start(it::FASTAIterator)
    advance!(it)
    return nothing
end


function next(it::FASTAIterator, state)
    item = it.nextitem
    advance!(it)
    return item, nothing
end


function done(it::FASTAIterator, state)
    return it.isdone
end
