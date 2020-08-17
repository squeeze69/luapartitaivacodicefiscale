-- include "codicefiscale.lua", NON va messa l'estensione
require("codicefiscale")
--[[
CODICE DI TEST -- CODICE DI TEST
codice di test, considerare solo la funzione soprastante
--]]
-- codici validi (formalmente - ogni somiglianza con eventuali codici reali è casuale)
testOK = {"ABCDEF12B23P432P", "MROrSs00a00A000U", ""}
-- codici non validi
testKO = {"ABCDEF12B23P432X", "MRORSS00A00A000V", "MROrSs00a00-A00U", "MRORSS00A.+A000V", "MROrSs00a00A000"}

print("--TEST: Risultato negativo (deve dare false)--")
print(string.format("numero=%s,%q",codicefiscale(1234)))
print(string.format("booleano=%s,%q",codicefiscale(true)))
for k,v in pairs(testKO) do
	print(string.format("%q=%s,%q",v,codicefiscale(v)))
end

print("--TEST: Risultato positivo (deve dare true)--")
for k,v in pairs(testOK) do
	print(string.format("%q=%s,%q",v,codicefiscale(v)))
end
