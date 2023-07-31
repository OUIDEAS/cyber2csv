function Exp1InitPPPRTK = BESTPOS_Log_Reader(filename, dataLines)
%IMPORTFILE Import data from a text file
%  EXP1INITPPPRTK = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  EXP1INITPPPRTK = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  Exp1InitPPPRTK = Telnet_Log_Reader("/home/autobuntu/Documents/PPP_RTK_Tests/07272023_novatel_logs/Exp1_Init_PPP_RTK.txt", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 28-Jul-2023 09:35:07

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 27);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = [" ", "<"];

% Specify column names and types
opts.VariableNames = ["ICOM3",  "BESTPOS",      "ICOM1",    "VarName4", "VarName5", "FINESTEERING", "SolStat",      "PosType",      "Lat",      "Lon",      "Alt",      "Undulation",   "Datum",            "LatStd", "LonStd", "AltStd", "BaseID", "diff_age", "soln_age", "NumSats", "NumSatsSoln",   "NumL1E1B1",    "NumMultFreq",  "Reserved", "SolnStat", "GalileoBejDou",    "GPSGLONASS"];
opts.VariableTypes = ["double", "categorical",  "double",   "double",   "double",   "categorical",  "categorical",  "categorical",  "double",   "double",   "double",   "double",       "categorical",      "double", "double", "double", "double", "double",   "double",   "double",   "double",       "double",       "double",       "double",   "double",   "double",           "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
% opts = setvaropts(opts, ["BESTPOS", "FINESTEERING", "SolStat", "PosType"], "EmptyFieldRule", "auto");
% opts = setvaropts(opts, ["ICOM3", "ICOM1", "Lon", "Datum"], "TrimNonNumeric", true);
% opts = setvaropts(opts, ["ICOM3", "ICOM1", "Lon", "Datum"], "ThousandsSeparator", ",");

% Import the data
Exp1InitPPPRTK = readtable(filename, opts);

end