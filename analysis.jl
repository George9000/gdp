# Note there are state GDP files with the codes L (for < $50k in GDP), NM (for not meaningful), or D (not disclosed)
# These values will be converted to missings

using gdp, DataFrames, MethodChains
# for "./data" substitute whatever directory holds the gdp data
const filenames = @mc readdir(abspath("./data"), join = true).{
    it[occursin.(r"\.csv$", it)]
}

readgdps(filenames; footerskip = 4, missingstring = ["", "(NA)", "(L)", "(NM)", "(D)"],
 pool = Dict(:TableName => true, :Unit => true))


@mc readgdps(filenames; footerskip = 4,
    missingstring = ["", "(NA)", "(L)", "(NM)", "(D)"],
    pool = Dict(:TableName => true, :Unit => true)).{
        describe(it, :nunique, :nmissing, :eltype)
        }