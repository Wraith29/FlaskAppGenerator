import 
    strformat,
    strutils,
    os

when isMainModule:
    var
        isApi:           bool   = false
        apiInp:          string
        filePath:        string
        templ:           string
        defaultFilePath: string = os.getAppDir()


    echo "File Path: "
    filePath = readLine(stdin)

    if not dirExists(filePath):
        createDir(filePath)

    echo "Api / App: "
    apiInp = readLine(stdin)

    case apiInp.toLower():
        of "api":
            isApi = true
        of "app":
            isApi = false
        else:
            echo "Invalid. Please Restart"
            quit(1)
    
    templ = readFile(fmt"{defaultFilePath}\..\templates\main.{apiInp.toLower()}.py")
    createDir(fmt"{filePath}\{apiInp.toLower()}")
    createDir(fmt"{filePath}\{apiInp.toLower()}\routes")
    writeFile(fmt"{filePath}\{apiInp.toLower()}\routes\__init__.py", "")

    writeFile(fmt"{filePath}\main.py", templ)    
    writeFile(
        fmt"{filePath}\{apiInp.toLower()}\__init__.py", 
        readFile(fmt"{defaultFilePath}\..\templates\{apiInp.toLower()}\__init__.py")
    )
    

    if not isApi:
        createDir(fmt"{filePath}\app\static")
        writeFile(
            fmt"{filePath}\app\static\styles.css", ""
        )
        createDir(fmt"{filePath}\app\templates")
        writeFile(
            fmt"{filePath}\app\templates\base.html",
            readFile(fmt"{defaultFilePath}\..\templates\app\templates\base.html")
        )
    
