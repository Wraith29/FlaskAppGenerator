import 
    strformat,
    strutils,
    std/os

when isMainModule:
    var
        isApi:           bool   = false
        apiInp:          string
        filePath:        string
        templ:           string
        defaultFilePath: string = "C:/Users/iacna/..Programming/flask-gen-nim"


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
    
    templ = readFile(&"{defaultFilePath}/templates/main.{apiInp.toLower()}.py")
    createDir(&"{filePath}/{apiInp.toLower()}")
    createDir(&"{filePath}/{apiInp.toLower()}/routes")
    writeFile(&"{filePath}/{apiInp.toLower()}/routes/__init__.py", "")

    writeFile(&"{filePath}/main.py", templ)    
    writeFile(
        &"{filePath}/{apiInp.toLower()}/__init__.py", 
        readFile(&"{defaultFilePath}/templates/{apiInp.toLower()}/__init__.py")
    )
    

    if not isApi:
        createDir(&"{filePath}/app/static")
        writeFile(
            &"{filePath}/app/static/styles.css", ""
        )
        createDir(&"{filePath}/app/templates")
        writeFile(
            &"{filePath}/app/templates/base.html",
            readFile(&"{defaultFilePath}/templates/app/templates/base.html")
        )
    
