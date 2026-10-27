# tsmineserver 클라이언트 설치기: Forge 1.19.2 + 서버 필수 모드
# 다시 실행하면 모드 목록을 이 파일 기준으로 맞춤 (업데이트용)
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'  # PS 5.1에서 진행바가 다운로드를 크게 느리게 함

$Forge   = '1.19.2-43.5.0'
$ProfileKey = 'forge'
$Server  = 'tsmineserver.kro.kr'
$Mc      = Join-Path $env:APPDATA '.minecraft'
$GameDir = Join-Path $env:APPDATA '.minecraft-tsmine'

# 서버 모드 바꾸면 이 목록만 고치면 됨 (파일명, URL, sha512)
$Mods = @(
  @('IC2Classic-1.19.2-2.1.3.4.jar', 'https://cdn.modrinth.com/data/nIaMQHTd/versions/Qy5qeGTB/IC2Classic-1.19.2-2.1.3.4.jar', '41f4881479c2285354ed405518303ce43cb47b85f5e61c0dbc3bb16dfc6207dcf2ea4781e1bb6371f7f5d4a11c3f3ed77acc137aa0f8b314c3a9984a387739be'),
  @('theoneprobe-1.19-6.2.2.jar', 'https://cdn.modrinth.com/data/Eyw0UxEx/versions/KCnKC3d7/theoneprobe-1.19-6.2.2.jar', '3ebd24ab9e61c54101458163f04a3bff40d244da2edee302939bf8248aeacb590bd343c153701de3ecc1cccc80058ac1e5bb6f09f13251b5c94e63e3b6f0eeb2'),
  @('CarbonConfig-1.19.2-2.0.2.jar', 'https://cdn.modrinth.com/data/1jDdpgcc/versions/HMD2FUea/CarbonConfig-1.19.2-2.0.2.jar', 'ef8c39e03414e727e72d297f568faf104af4b6ad3861941653f6692dac5b374943d9d4b0550fe22e1525e5e875d3543c9b5474c4fa621839b6bf356ffe3b750a'),
  @('MutantMonsters-v4.0.6-1.19.2-Forge.jar', 'https://cdn.modrinth.com/data/derP0ten/versions/CkbS2PLp/MutantMonsters-v4.0.6-1.19.2-Forge.jar', 'd6c625b7e50ecc0cefb5c6e7d0fd0a8f2f10af45e6b97a419e3e8d946aefb2f011018cd40dcfa2b04de55a58195922eabead299a41715a36e51542a06ccbac8d'),
  @('PuzzlesLib-v4.4.3-1.19.2-Forge.jar', 'https://cdn.modrinth.com/data/QAGBst4M/versions/UbCrBSit/PuzzlesLib-v4.4.3-1.19.2-Forge.jar', 'a17fae22581d7a2c6947ba6fc58b38f34197e22aec430dbaa6eee7104cf891b9e9abbea5a322c04b1f3f1df04fa7462f603ca5c2d7ad3657198cc3989fda7bd2'),
  @('ecologics-forge-1.19.2-2.1.11.jar', 'https://cdn.modrinth.com/data/NCKpPR0Z/versions/hOFm4e6B/ecologics-forge-1.19.2-2.1.11.jar', '2ecd22090f5d75c6994673b49b72287ad6c656b4e68078b7b7cb52f9d593a19bd748945c320c49b26a0f922c590e059deecdd9bec6ff2135d3458cb9c4cd9d2d'),
  @('paladin-furniture-mod-1.5.0-forge-mc1.19.jar', 'https://cdn.modrinth.com/data/SISz7Qd3/versions/X8t9adzB/paladin-furniture-mod-1.5.0-forge-mc1.19.jar', '26f7c3803afe966e54fbbbe7faa20f47c280c70fb292f826db4e663936bfa11feef38559b2ffc78fa53601c6caa97ae3489f2ce1a8052437435ca44901008700'),
  # 클라이언트 전용 (서버에 없어도 접속 가능)
  # JEI 11.68.x는 1.19.2에서 크래시(AbstractMethodError). 마지막 안정판 11.6.0.1024 고정
  @('jei-1.19.2-forge-11.6.0.1024.jar', 'https://cdn.modrinth.com/data/u6dRKJwZ/versions/8HIXqeHh/jei-1.19.2-forge-11.6.0.1024.jar', '68b5a27e8cbc33c8866b4014f3ef3965427067eeac311021c0999352cad45f41b8f5f74b10ed34f279554565e9574c4554eb51e18c6561b8f4f1f2a0933e5cef'),
  @('embeddium-0.3.18.1+mc1.19.2.jar', 'https://cdn.modrinth.com/data/sk9rgfiA/versions/AYqEbec0/embeddium-0.3.18.1%2Bmc1.19.2.jar', '33d88ab9f2bb73801d53461d0b7f7149ddae531373b4746c05259a4608e3115d7966a8643bac4c76e66a1cbc39d6f3a4929bdd95237bb79a6274ac16c6f53b46'),
  # 셰이더 로더. Embeddium이 rubidium 호환 ID를 제공해서 Rubidium 없이 동작
  @('oculus-mc1.19.2-1.6.9a.jar', 'https://cdn.modrinth.com/data/GchcoXML/versions/Mw8aFpWF/oculus-mc1.19.2-1.6.9a.jar', 'b59fad480777d0d4d9f51f9eb0d148a9a0776c76069b1e6211371c266ab3ac516d8f2c4e0bb223bce73e73c983072c700a241bde82be2cffcb9252b1db598c8a'),
  # JEI에 UU 물질/플라즈마 제작 페이지 추가
  @('ic2cuumatter-1.19.2-1.3.2.jar', 'https://cdn.modrinth.com/data/FOVCOVzb/versions/NXWGaEaH/ic2cuumatter-1.19.2-1.3.2.jar', '30bb962a849059517d1fa2ae8647c5f50a9717e48d91a4a9ab13c7e18dc03d5be1eea77f379c4ac38b40eb9102e2415bddd337efecae01d5b057eedc1d5e6de8'),
  @('zume-1.2.2.jar', 'https://cdn.modrinth.com/data/o6qsdrrQ/versions/Rh2ImJ86/zume-1.2.2.jar', '9803fcf070327ed40316f8323ad7de83977a4ff8dc928c892836c8f49a9be3da6e9282aa85bf8bcf3467c4339f3d16dad5ec92d1a2e9bc9fc10bddba1ffc1190'),
  @('entityculling-forge-1.6.1-mc1.19.2.jar', 'https://cdn.modrinth.com/data/NNAgCjsB/versions/WR6z6MYC/entityculling-forge-1.6.1-mc1.19.2.jar', 'ecd71617e1b72cfcfade5c61b121e67b3c5f26a43a9521122209f0242e580020916202665517f4b95a4a5b84794d80d61009c6333c1e1a49e180de9da21dc881')
)

function Fail($msg) { Write-Host "`n[실패] $msg" -ForegroundColor Red; exit 1 }

$ProfilesFile = Join-Path $Mc 'launcher_profiles.json'
if (-not (Test-Path $ProfilesFile)) { Fail 'Minecraft 런처를 한 번 실행하고 로그인한 뒤 다시 실행하세요.' }

# 1. Java: 런처에 딸린 것 우선 (공식 런처, MS Store 런처), 없으면 시스템 java
Write-Host '[1/4] Java 찾는 중...'
$roots = @(
  (Join-Path $Mc 'runtime'),
  (Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.4297127D64EC6_8wekyb3d8bbwe\LocalCache\Local\runtime'),
  (Join-Path ${env:ProgramFiles(x86)} 'Minecraft Launcher\runtime')
) | Where-Object { Test-Path $_ }
$java = $roots | ForEach-Object { Get-ChildItem $_ -Recurse -Filter java.exe -ErrorAction SilentlyContinue } |
  Select-Object -First 1 -ExpandProperty FullName
if (-not $java) { $java = (Get-Command java -ErrorAction SilentlyContinue).Source }
if (-not $java) { Fail 'Java를 못 찾음. Minecraft 런처에서 아무 버전이나 한 번 실행한 뒤 다시 시도하세요.' }
Write-Host "      $java"

# 2. Forge
Write-Host "[2/4] Forge $Forge 설치 중... (1~3분)"
if (Test-Path (Join-Path $Mc "versions\1.19.2-forge-43.5.0")) {
  Write-Host '      이미 설치됨, 건너뜀'
} else {
  $tmp = Join-Path $env:TEMP 'tsmine-forge'
  New-Item -ItemType Directory -Force $tmp | Out-Null
  $inst = Join-Path $tmp 'forge-installer.jar'
  Invoke-WebRequest -UseBasicParsing "https://maven.minecraftforge.net/net/minecraftforge/forge/$Forge/forge-$Forge-installer.jar" -OutFile $inst
  & $java -jar $inst --installClient $Mc *> (Join-Path $tmp 'install.log')
  if ($LASTEXITCODE -ne 0) { Fail "Forge 설치 실패. 로그: $tmp\install.log" }
}

# 3. 모드: 전용 폴더에 받아서 sha512 검증, 목록에 없는 jar는 제거
Write-Host '[3/4] 모드 받는 중...'
$ModsDir = Join-Path $GameDir 'mods'
New-Item -ItemType Directory -Force $ModsDir | Out-Null
foreach ($m in $Mods) {
  $path = Join-Path $ModsDir $m[0]
  $ok = (Test-Path $path) -and ((Get-FileHash $path -Algorithm SHA512).Hash -eq $m[2])
  if (-not $ok) {
    Invoke-WebRequest -UseBasicParsing $m[1] -OutFile $path
    if ((Get-FileHash $path -Algorithm SHA512).Hash -ne $m[2]) { Remove-Item $path; Fail "$($m[0]) 해시 불일치. 다운로드가 손상됨." }
  }
  Write-Host "      OK  $($m[0])"
}
$keep = $Mods | ForEach-Object { $_[0] }
Get-ChildItem $ModsDir -Filter *.jar | Where-Object { $keep -notcontains $_.Name } | ForEach-Object {
  Remove-Item $_.FullName; Write-Host "      삭제 $($_.Name)"
}

# 4. 런처 프로필: 전용 폴더 + 메모리 4GB
Write-Host '[4/4] 런처 프로필 설정 중...'
Copy-Item $ProfilesFile "$ProfilesFile.bak" -Force
$json = Get-Content $ProfilesFile -Raw -Encoding UTF8 | ConvertFrom-Json
$p = $json.profiles.$ProfileKey
if (-not $p) { Fail "런처에 '$ProfileKey' 프로필이 없음. Forge 설치가 제대로 안 된 것 같음." }
$p | Add-Member -Force NoteProperty name 'tsmineserver (IC2)'
$p | Add-Member -Force NoteProperty gameDir $GameDir
$p | Add-Member -Force NoteProperty javaArgs '-Xmx4G -XX:+UseG1GC'
[IO.File]::WriteAllText($ProfilesFile, ($json | ConvertTo-Json -Depth 20), (New-Object Text.UTF8Encoding $false))

Write-Host "`n[완료]" -ForegroundColor Green
Write-Host "1. Minecraft 런처를 껐다 켭니다."
Write-Host "2. 플레이 버튼 왼쪽에서 'tsmineserver (IC2)' 를 고릅니다."
Write-Host "3. 멀티플레이 > 서버 추가 > 주소: $Server"
