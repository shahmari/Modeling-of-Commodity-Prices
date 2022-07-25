module CostumMods

export ConvertDate, GetProdName, GetGroupName, GroupToProduct, FindNearsts, FindMeanPrice

using Dates

GroupDict = Dict(1 => "Industrial",
    2 => "Agriculture",
    3 => "Petrochemical",
    4 => "Mineral",
    5 => "Oil",
    6 => "Immovable")

ProductDict = Dict(1 => "Steel",
    2 => "aluminium",
    3 => "copper",
    4 => "Zinc",
    5 => "concentrate",
    6 => "Molybdenum concentrate",
    20 => "Gold",
    38 => "Nickel",
    40 => "coke",
    41 => "Cement",
    49 => "Limestone",
    90 => "Lead",
    91 => "car",
    97 => "Direct Reduced Iron",
    104 => "Cast iron",
    109 => "Counter",
    7 => "Rice",
    8 => "Pistachio",
    9 => "Sugar",
    10 => "Press Meal",
    11 => "barley",
    12 => "Corn",
    13 => "Wheat",
    14 => "Concentrates and pulp",
    28 => "Pea",
    30 => "Saffron",
    31 => "Date",
    32 => "Lentils",
    34 => "Raisins",
    35 => "Tea",
    39 => "Frozen chicken",
    44 => "egg",
    48 => "Cumin",
    50 => "Cotton wool",
    70 => "Oil Seeds",
    77 => "tomato paste",
    79 => "Raw oil",
    94 => "Hen",
    98 => "Edible Oil",
    29 => "Coal and coke",
    96 => "Direct Reduced Iron",
    99 => "Zinc",
    68 => "Real estates",
    15 => "Industrial soot",
    16 => "bitumen",
    18 => "Oil",
    19 => "Extract",
    22 => "Chemical",
    23 => "Naphtha",
    27 => "Sulfur",
    33 => "polymer",
    37 => "Gases and feeds",
    42 => "Vacuum Batuum",
    43 => "Isoricycles",
    45 => "Cut Lob",
    46 => "Petrol",
    47 => "petroleum",
    51 => "Aizofid",
    52 => "oil products",
    67 => "Petroleum solvent",
    69 => "Slaps Wax",
    72 => "Waterproofing",
    105 => "Pure bitumen",
    106 => "Bitumen emulsion",
    107 => "Soluble bitumen",
    108 => "Modified bitumen",
    111 => "Petroleum bitumen",
    113 => "Bitumen blown",
    53 => "bitumen",
    54 => "Vacuum Batuum",
    55 => "Isoricycles",
    56 => "Cut Lob",
    57 => "Aizofid",
    58 => "petroleum",
    60 => "Petrol",
    61 => "Naphtha",
    62 => "Extract",
    63 => "Oil",
    64 => "Petroleum solvent",
    65 => "Slack Wax",
    66 => "Paraffin wax"
)

GetProdName(PN::Integer) = ProductDict[PN]
GetGroupName(GN::Integer) = GroupDict[GN]
GetCategoryName(Str::String) = GroupDict[parse(Int, split(Str, "-")[1])] * " - " * ProductDict[parse(Int, split(Str, "-")[2])]
ConvertDate(x::Integer) = parse(Int, string(x)[7:8]) + (parse(Int, string(x)[5:6])) * 30 + (parse(Int, string(x)[1:4])) * 365 - 509191
BaseDate = Date(2016, 3, 12)
ConvertToDateTime(Nd::Int) = BaseDate + Day(Nd)
function GroupToProduct(PN::Integer)
    if PN ∈ [1, 2, 3, 4, 5, 6, 20, 38, 40, 41, 49, 90, 91, 97, 104, 109]
        return 1
    elseif PN ∈ [7, 8, 9, 10, 11, 12, 13, 14, 28, 30, 31, 32, 34, 35, 39, 44, 48, 50, 70, 77, 79, 94, 98]
        return 2
    elseif PN ∈ [15, 16, 18, 19, 22, 23, 27, 33, 37, 42, 43, 45, 46, 47, 51, 52, 67, 69, 72, 105, 106, 107, 108, 111, 113]
        return 3
    elseif PN ∈ [29, 96, 99]
        return 4
    elseif PN ∈ [53, 54, 55, 56, 57, 58, 60, 61, 62, 63, 64, 65, 66]
        return 5
    elseif PN ∈ [68]
        return 6
    else
        return nothing
    end
end

function FindNearsts(Ans::Vector{Int64}, x::Int64)
    nearindex = findmin(abs.(Ans .- x))[2]
    if Ans[nearindex] > x
        return nearindex - 1, nearindex
    else
        return nearindex, nearindex + 1
    end
end

function FindMeanPrice(PriceAns::Vector{Float64}, DatesAns::Vector{Int64}, x::Int64)
    first, last = FindNearsts(DatesAns, x)
    return (PriceAns[first] + PriceAns[last]) / 2
end

end




