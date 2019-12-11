@echo off

::create nuget_pub
if not exist nuget_pub (
    md nuget_pub
)

::clear nuget_pub
for /R "nuget_pub" %%s in (*) do (
    del %%s
)

::Standard
dotnet pack src/Cosmos -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions.Asyncs -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions.Domain -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions.DateTime -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions.Collections -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions.Preconditions -c Release -o nuget_pub
dotnet pack src/Cosmos.Extensions.Reflection -c Release -o nuget_pub
dotnet pack src/Cosmos.Abstractions -c Release -o nuget_pub
dotnet pack src/Cosmos.Standard -c Release -o nuget_pub

::Extensions for serialization
dotnet pack extra/serialization/src/Cosmos.serialization.Xml -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.Jil -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.Lit -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.serialization.Binary -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.Swifter -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.Utf8Json -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.Protobuf -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.KoobooJson -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.SharpYaml -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.YamlDotNet -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.MsgPackCli -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.MessagePack -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.ZeroFormatter -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.MicrosoftJson -c Release -o nuget_pub
dotnet pack extra/serialization/src/Cosmos.Serialization.NewtonsoftJson -c Release -o nuget_pub

::Extensions for dependency/ioc
dotnet pack extra/dependency/src/Cosmos.Extensions.Autofac -c Release -o nuget_pub
dotnet pack extra/dependency/src/Cosmos.Extensions.AspectCoreInjector -c Release -o nuget_pub
dotnet pack extra/dependency/src/Cosmos.Extensions.DependencyInjection -c Release -o nuget_pub

::Extensions for http
dotnet pack extra/http/src/Cosmos.Extensions.Http -c Release -o nuget_pub

for /R "nuget_pub" %%s in (*symbols.nupkg) do (
    del %%s
)

echo.
echo.

set /p key=input key:
set source=https://api.nuget.org/v3/index.json

for /R "nuget_pub" %%s in (*.nupkg) do ( 
    call nuget push %%s %key% -Source %source%	
	echo.
)

pause