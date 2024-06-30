module gdp
using CSV, DataFrames, Missings, MethodChains, CategoricalArrays
# import TableTransforms: StdNames
export readgdps

"""
    readgdps(paths::Vector{String}; kwargs...)

Read a list of state gdp csvs, concatenate together, dump into one dataframe.
"""
function readgdps(paths::Vector{String}; kwargs...)
    df = CSV.read(paths, DataFrame; kwargs...)
    nms = names(df, r"^\d")
    newnms = (str -> "y".*str)(nms)
    rename!(df, nms .=> newnms)
    transform!(df, [:GeoName, :IndustryClassification, :Description] .=> categorical, renamecols = false)
end

end # module gdp
