-- VANTYS LOGO EXPLORER 2000 • v1.4
-- Discord: vantys22
-- PC controls:
-- Arrow keys: move guide
-- Shift + arrows: move faster
-- H: toggle guide
-- Enable "Move guide" to drag it with the mouse.
-- Logo images are downloaded online.
-- The catalog contains 500 names, not 500 bundled images.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local Http = game:GetService("HttpService")

local pg = Players.LocalPlayer:WaitForChild("PlayerGui")
local requestFn = request or http_request or (syn and syn.request)
local assetFn = getcustomasset or getsynasset

if not requestFn or not assetFn or type(writefile) ~= "function" then
    warn("Vantys: request, writefile and getcustomasset are required.")
    return
end

local env = getgenv and getgenv() or _G
for _, key in ipairs({
    "VantysLogoStop", "WebLogoStop",
    "MakeLogoGuideStop", "MakeLogoHelperStop"
}) do
    if type(env[key]) == "function" then
        pcall(env[key])
    end
end

local BRANDS_TEXT = [[
Apple|Duolingo|Gmail|Roblox|Audi|YouTube|Google|Microsoft|Windows|Xbox|PlayStation|Nintendo|Steam|Discord|Spotify|Netflix|Twitch|TikTok|Instagram|Facebook|WhatsApp|Telegram|Snapchat|Pinterest|Reddit|LinkedIn|X|Skype|Zoom|Slack|Dropbox|OneDrive|Google Drive|Google Maps|Google Chrome|Firefox|Safari|Opera|Brave|Edge|Bing|Yahoo|DuckDuckGo|Wikipedia|Wikimedia|GitHub|GitLab|Bitbucket|Stack Overflow
Amazon|eBay|Alibaba|AliExpress|Temu|Shein|Etsy|Shopify|Walmart|Target|Costco|IKEA|Carrefour|Tesco|Aldi|Lidl|Auchan|Metro|7-Eleven|Best Buy|Home Depot|Lowe's|Macy's|Nordstrom|Sears|Kroger|Walgreens|CVS|Boots|Sephora|Ulta Beauty|Zalando|ASOS|Vinted|Depop|Mercari|Rakuten|Flipkart|Shopee|Lazada|JD.com|Pinduoduo|Wish|Wayfair|Overstock|Newegg|GameStop|Decathlon|REI|Fnac
Nike|Adidas|Puma|Reebok|Under Armour|New Balance|Converse|Vans|Fila|Asics|Skechers|Jordan|Champion|Umbro|Kappa|Lacoste|Levi's|Wrangler|Lee|Diesel|Gucci|Prada|Versace|Armani|Louis Vuitton|Dior|Chanel|Hermes|Burberry|Balenciaga|Givenchy|Fendi|Valentino|Dolce & Gabbana|Saint Laurent|Celine|Bottega Veneta|Tom Ford|Ralph Lauren|Tommy Hilfiger|Calvin Klein|Hugo Boss|Zara|H&M|Uniqlo|Gap|Old Navy|Pull&Bear|Bershka|Mango
McDonald's|Burger King|KFC|Subway|Pizza Hut|Domino's|Papa John's|Taco Bell|Wendy's|Dunkin'|Starbucks|Costa Coffee|Tim Hortons|Nando's|Popeyes|Chick-fil-A|Chipotle|Five Guys|Shake Shack|In-N-Out Burger|Little Caesars|Dairy Queen|Baskin-Robbins|Krispy Kreme|Pret a Manger|Panera Bread|IHOP|Denny's|Applebee's|Chili's|Olive Garden|Red Lobster|Outback Steakhouse|Hard Rock Cafe|Cinnabon|Auntie Anne's|Jollibee|Greggs|Wagamama|Yo! Sushi|Sbarro|Carl's Jr.|Hardee's|Jack in the Box|Sonic Drive-In|Arby's|White Castle|Whataburger|Culver's|Del Taco
Coca-Cola|Pepsi|Fanta|Sprite|7 Up|Mountain Dew|Dr Pepper|Mirinda|Schweppes|Canada Dry|Red Bull|Monster Energy|Rockstar Energy|Gatorade|Powerade|Prime Hydration|Evian|Perrier|San Pellegrino|Volvic|Aquafina|Dasani|Lipton|Nestea|Tropicana|Minute Maid|Ocean Spray|Capri-Sun|Nesquik|Nescafe|Lavazza|Illy|Jacobs|Tchibo|Twinings|Tetley|PG Tips|Nespresso|Ovaltine|Milo|Heineken|Carlsberg|Budweiser|Corona|Guinness|Stella Artois|Beck's|Bacardi|Smirnoff|Absolut
BMW|Mercedes-Benz|Volkswagen|Porsche|Ferrari|Lamborghini|Maserati|Bugatti|Bentley|Rolls-Royce|Aston Martin|McLaren|Lotus|Jaguar|Land Rover|Mini|Volvo|Saab|Polestar|Tesla|Ford|Chevrolet|GMC|Cadillac|Buick|Chrysler|Dodge|Jeep|Ram|Lincoln|Toyota|Lexus|Honda|Acura|Nissan|Infiniti|Mazda|Subaru|Mitsubishi|Suzuki|Hyundai|Kia|Genesis|Renault|Peugeot|Citroen|Fiat|Alfa Romeo|Skoda|Seat
Samsung|LG|Sony|Panasonic|Philips|Sharp|Toshiba|Hitachi|Fujitsu|NEC|Canon|Nikon|Olympus|Fujifilm|Kodak|GoPro|DJI|Garmin|Fitbit|Huawei|Honor|Xiaomi|Redmi|OnePlus|Oppo|Vivo|Realme|Nothing|Motorola|Nokia|BlackBerry|HTC|Asus|Acer|Lenovo|Dell|HP|MSI|Razer|Alienware|Logitech|Corsair|SteelSeries|HyperX|Intel|AMD|Nvidia|Qualcomm|MediaTek|Broadcom
Adobe|Photoshop|Illustrator|Premiere Pro|After Effects|Figma|Canva|Sketch|Blender|Unity|Unreal Engine|Godot|Autodesk|AutoCAD|Maya|Cinema 4D|SketchUp|Notion|Obsidian|Evernote|Trello|Asana|Monday.com|ClickUp|Airtable|Salesforce|Oracle|SAP|IBM|Cisco|VMware|Docker|Kubernetes|Linux|Ubuntu|Debian|Fedora|Arch Linux|Red Hat|Android|iOS|WordPress|Squarespace|Wix|Webflow|Cloudflare|DigitalOcean|Vercel|Netlify|Heroku
Disney|Pixar|DreamWorks|Warner Bros.|Universal Pictures|Paramount Pictures|Columbia Pictures|Sony Pictures|MGM|20th Century Studios|Marvel|DC Comics|Star Wars|Harry Potter|Pokemon|Super Mario|Sonic|Minecraft|Fortnite|League of Legends|Dota 2|Counter-Strike|Valorant|Overwatch|World of Warcraft|Diablo|Hearthstone|Call of Duty|Battlefield|Grand Theft Auto|Red Dead Redemption|The Sims|Need for Speed|FIFA|EA Sports|Electronic Arts|Ubisoft|Rockstar Games|Valve|Epic Games|Riot Games|Blizzard|Activision|Bethesda|Capcom|Konami|Sega|Bandai Namco|Square Enix|Atari
Visa|Mastercard|American Express|PayPal|Venmo|Cash App|Stripe|Klarna|Revolut|Wise|Monzo|N26|HSBC|Barclays|Santander|Deutsche Bank|UBS|Chase|Citibank|Bank of America|Wells Fargo|Goldman Sachs|Morgan Stanley|BNP Paribas|ING|Allianz|AXA|Zurich Insurance|Prudential|MetLife|FedEx|UPS|DHL|USPS|Royal Mail|DPD|GLS|Maersk|MSC|CMA CGM|Emirates|Qatar Airways|Lufthansa|Air France|KLM|British Airways|Ryanair|easyJet|Turkish Airlines|Singapore Airlines|BP
]]

local brands = {}
for name in BRANDS_TEXT:gmatch("[^|\r\n]+") do
    table.insert(brands, name)
end
table.sort(brands, function(a, b)
    return a:lower() < b:lower()
end)

local alive = true
local connections = {}
local positions, imageCache, logoCache = {}, {}, {}
local root, canvas, theme
local current, serial = "", 0
local automatic, guideEnabled, moveMode = true, true, false
local opacity = 0.80
local variants, variantIndex = {}, 1
local draggingWindow, draggingGuide = false, false
local dragStart, panelStart, guideStart
local autoButton, guideButton, moveButton, opacityLabel

local GREY = Color3.fromRGB(192, 192, 192)
local WHITE = Color3.new(1, 1, 1)
local BLACK = Color3.new(0, 0, 0)
local DARK = Color3.fromRGB(80, 80, 80)
local GREEN = Color3.fromRGB(0, 255, 125)
local BLUE = Color3.fromRGB(0, 0, 128)

local function on(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(connections, connection)
    return connection
end

local function make(class, parent, properties)
    local object = Instance.new(class)
    for key, value in pairs(properties or {}) do
        object[key] = value
    end
    object.Parent = parent
    return object
end

local function passThrough(object)
    object.Active = false
    object.Selectable = false
    pcall(function()
        object.Interactable = false
    end)
end

local function bevel(object, inset)
    local light = inset and DARK or WHITE
    local dark = inset and WHITE or DARK

    for _, edge in ipairs({
        {UDim2.new(), UDim2.new(1, 0, 0, 2), light},
        {UDim2.new(), UDim2.new(0, 2, 1, 0), light},
        {UDim2.new(0, 0, 1, -2), UDim2.new(1, 0, 0, 2), dark},
        {UDim2.new(1, -2, 0, 0), UDim2.new(0, 2, 1, 0), dark},
    }) do
        local line = make("Frame", object, {
            Position = edge[1],
            Size = edge[2],
            BackgroundColor3 = edge[3],
            BorderSizePixel = 0,
        })
        passThrough(line)
    end
end

local gui = make("ScreenGui", pg, {
    Name = "Vantys2000Menu",
    ResetOnSpawn = false,
    DisplayOrder = 10001,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

local overlayGui = make("ScreenGui", pg, {
    Name = "Vantys2000Overlay",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 10000,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

local overlay = make("Frame", overlayGui, {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClipsDescendants = false,
    Visible = false,
})
passThrough(overlay)

local guide = make("ImageLabel", overlay, {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ImageColor3 = WHITE,
    ImageTransparency = 1 - opacity,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 2,
})
passThrough(guide)

local outline = make("UIStroke", guide, {
    Color = GREEN,
    Thickness = 2,
    Transparency = 0.15,
})

-- Interactive only while Move guide is enabled.
-- It is a sibling of the non-interactive image.
local guideHandle = make("TextButton", overlay, {
    AnchorPoint = Vector2.new(0.5, 1),
    Size = UDim2.fromOffset(160, 24),
    BackgroundColor3 = BLUE,
    BorderColor3 = WHITE,
    Text = "Drag guide",
    TextColor3 = WHITE,
    TextSize = 14,
    Font = Enum.Font.ArialBold,
    Active = true,
    Visible = false,
    ZIndex = 3,
})

local window = make("Frame", gui, {
    Position = UDim2.fromOffset(20, 65),
    Size = UDim2.fromOffset(360, 590),
    BackgroundColor3 = GREY,
    BorderSizePixel = 0,
    Active = true,
})
bevel(window, false)

local titlebar = make("TextLabel", window, {
    Position = UDim2.fromOffset(4, 4),
    Size = UDim2.new(1, -8, 0, 26),
    BackgroundColor3 = BLUE,
    BorderSizePixel = 0,
    Text = "  Vantys Logo Explorer 2000",
    TextColor3 = WHITE,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextSize = 15,
    Font = Enum.Font.ArialBold,
    Active = true,
})

make("UIGradient", titlebar, {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, BLUE),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 135, 205)),
    }),
})

local function label(parent, value, x, y, w, h)
    return make("TextLabel", parent, {
        Position = UDim2.fromOffset(x, y),
        Size = UDim2.fromOffset(w, h),
        BackgroundTransparency = 1,
        Text = value,
        TextColor3 = BLACK,
        TextSize = 14,
        TextWrapped = true,
        Font = Enum.Font.Arial,
    })
end

local function button(parent, value, x, y, w, h, callback)
    local object = make("TextButton", parent, {
        Position = UDim2.fromOffset(x, y),
        Size = UDim2.fromOffset(w, h),
        BackgroundColor3 = GREY,
        BorderSizePixel = 0,
        Text = value,
        TextColor3 = BLACK,
        TextSize = 14,
        Font = Enum.Font.Arial,
    })
    bevel(object, false)
    on(object.Activated, callback)
    return object
end

local main = make("Frame", window, {
    Position = UDim2.fromOffset(10, 74),
    Size = UDim2.fromOffset(340, 478),
    BackgroundTransparency = 1,
})

local support = make("Frame", window, {
    Position = main.Position,
    Size = main.Size,
    BackgroundTransparency = 1,
    Visible = false,
})

button(window, "Logos", 10, 39, 108, 27, function()
    main.Visible = true
    support.Visible = false
end)

button(window, "Support", 123, 39, 94, 27, function()
    main.Visible = false
    support.Visible = true
end)

label(support, "VANTYS SUPPORT", 10, 36, 320, 35).Font =
    Enum.Font.ArialBold
label(support, "Discord", 10, 100, 320, 25)
label(support, "vantys22", 10, 135, 320, 40).TextSize = 28

local copyButton
copyButton = button(support, "Copy username", 80, 198, 180, 32, function()
    local ok = type(setclipboard) == "function"
        and pcall(setclipboard, "vantys22")
    copyButton.Text = ok and "Copied!" or "vantys22"
end)

local search = make("TextBox", main, {
    Size = UDim2.fromOffset(264, 28),
    BackgroundColor3 = WHITE,
    BorderSizePixel = 0,
    TextColor3 = BLACK,
    PlaceholderText = "Search logo",
    Text = "",
    TextSize = 14,
    Font = Enum.Font.Arial,
    ClearTextOnFocus = false,
})
bevel(search, true)

local logoTitle = label(main, "", 0, 33, 340, 22)
logoTitle.Font = Enum.Font.ArialBold

local preview = make("ImageLabel", main, {
    Position = UDim2.fromOffset(0, 59),
    Size = UDim2.fromOffset(340, 125),
    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
    BorderSizePixel = 0,
    ScaleType = Enum.ScaleType.Fit,
})
bevel(preview, true)

local notice = label(preview, "", 5, 5, 330, 115)
notice.TextColor3 = WHITE

local catalogLabel = label(main, "", 0, 378, 340, 20)
catalogLabel.TextSize = 12

local list = make("ScrollingFrame", main, {
    Position = UDim2.fromOffset(0, 403),
    Size = UDim2.fromOffset(340, 75),
    BackgroundColor3 = WHITE,
    BorderSizePixel = 1,
    BorderColor3 = DARK,
    ScrollBarThickness = 8,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
})

make("UIListLayout", list, {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 2),
})

local status = label(window, "Waiting for game", 10, 563, 340, 20)
status.TextSize = 12
status.TextXAlignment = Enum.TextXAlignment.Left
bevel(status, true)

local function config()
    positions[current] = positions[current] or {
        x = 0.5,
        y = 0.5,
        scale = 0.78125,
    }
    return positions[current]
end

local function updateGuide()
    if not alive then return end

    local c = config()

    guide.Position = UDim2.fromScale(c.x, c.y)
    guide.Size = UDim2.fromScale(c.scale, c.scale)
    guide.ImageTransparency = 1 - opacity

    guideHandle.Position = UDim2.fromScale(
        c.x,
        c.y - c.scale / 2
    )
    guideHandle.Visible = moveMode

    if guideButton then
        guideButton.Text = guideEnabled
            and "Guide: ON" or "Guide: OFF"
        guideButton.TextColor3 = guideEnabled
            and Color3.fromRGB(0, 100, 30)
            or Color3.fromRGB(145, 0, 0)
    end

    if moveButton then
        moveButton.Text = moveMode
            and "Move guide: ON" or "Move guide: OFF"
        moveButton.TextColor3 = moveMode
            and Color3.fromRGB(0, 60, 160) or BLACK
    end

    if opacityLabel then
        opacityLabel.Text = "Visibility: "
            .. math.floor(opacity * 100 + 0.5) .. "%"
    end

    if not root or not canvas or not canvas.Parent then
        overlay.Visible = false
        return
    end

    overlay.Position = UDim2.fromOffset(
        canvas.AbsolutePosition.X,
        canvas.AbsolutePosition.Y
    )
    overlay.Size = UDim2.fromOffset(
        canvas.AbsoluteSize.X,
        canvas.AbsoluteSize.Y
    )

    local visible = true
    local ancestor = canvas

    while ancestor and ancestor ~= pg do
        if ancestor:IsA("GuiObject") and not ancestor.Visible then
            visible = false
            break
        elseif ancestor:IsA("ScreenGui") and not ancestor.Enabled then
            visible = false
            break
        end
        ancestor = ancestor.Parent
    end

    local results = root:FindFirstChild("results")
    overlay.Visible = guideEnabled and visible
        and guide.Image ~= ""
        and not (results and results.Visible)
end

local function stop()
    if not alive then return end
    alive = false
    serial += 1

    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end

    overlayGui:Destroy()
    gui:Destroy()
end

env.VantysLogoStop = stop
env.WebLogoStop = stop
button(window, "X", 328, 7, 24, 20, stop)

local function get(url)
    local response = requestFn({
        Url = url,
        Method = "GET",
    })

    assert(type(response) == "table", "No server response")
    assert(response.StatusCode == 200,
        "HTTP " .. tostring(response.StatusCode))
    return response.Body
end

local function json(url)
    return Http:JSONDecode(get(url))
end

local function normalize(value)
    return value:lower():gsub("&", "and"):gsub("[^%w]", "")
end

local known = {
    apple = "Q312",
    audi = "Q23317",
    audiag = "Q23317",
    bp = "Q152057",
    google = "Q95",
    youtube = "Q866",
    microsoft = "Q2283",
    nike = "Q483915",
    adidas = "Q3895",
    mcdonalds = "Q38076",
    amazon = "Q3884",
    pepsi = "Q334800",
    cocacola = "Q2813",
}

local articles = {
    apple = "Apple Inc.",
    duolingo = "Duolingo",
    gmail = "Gmail",
    roblox = "Roblox",
    puma = "Puma (brand)",
    target = "Target Corporation",
    windows = "Microsoft Windows",
    jordan = "Air Jordan",
    sonic = "Sonic the Hedgehog",
    supermario = "Super Mario",
    pokemon = "Pokémon",
    starwars = "Star Wars",
    playstation = "PlayStation",
    underarmour = "Under Armour",
    burgerking = "Burger King",
    mercedes = "Mercedes-Benz",
    twitter = "Twitter",
    x = "Twitter",
    edge = "Microsoft Edge",
    safari = "Safari (web browser)",
    opera = "Opera (web browser)",
    brave = "Brave (web browser)",
    zoom = "Zoom (software)",
    slack = "Slack (software)",
    steam = "Steam (service)",
    valve = "Valve Corporation",
    disney = "The Walt Disney Company",
    marvel = "Marvel Entertainment",
    photoshop = "Adobe Photoshop",
    illustrator = "Adobe Illustrator",
    premierepro = "Adobe Premiere Pro",
    aftereffects = "Adobe After Effects",
    blender = "Blender (software)",
    unity = "Unity (game engine)",
    godot = "Godot (game engine)",
    maya = "Autodesk Maya",
    sketch = "Sketch (software)",
    notion = "Notion (productivity software)",
    obsidian = "Obsidian (software)",
    docker = "Docker (software)",
    android = "Android (operating system)",
    oracle = "Oracle Corporation",
    hp = "HP Inc.",
    lg = "LG Electronics",
    sharp = "Sharp Corporation",
    canon = "Canon Inc.",
    honor = "Honor (brand)",
    nothing = "Nothing (company)",
    mini = "Mini (marque)",
    genesis = "Genesis Motor",
    jaguar = "Jaguar Cars",
    ram = "Ram Trucks",
    lotus = "Lotus Cars",
    seat = "SEAT",
    champion = "Champion (sportswear)",
    lee = "Lee (jeans)",
    diesel = "Diesel (brand)",
    gap = "Gap Inc.",
    mango = "Mango (retailer)",
    metro = "Metro AG",
    boots = "Boots (company)",
    primehydration = "Prime (drink)",
    corona = "Corona (beer)",
    milo = "Milo (drink)",
    visa = "Visa Inc.",
    stripe = "Stripe, Inc.",
    wise = "Wise (company)",
    chase = "Chase Bank",
    ing = "ING Group",
    msc = "Mediterranean Shipping Company",
}

local function findLogos(query)
    local key = normalize(query)
    if logoCache[key] then return logoCache[key] end

    local ids, seenIDs = {}, {}

    local function addID(id)
        if type(id) == "string" and id:match("^Q%d+$")
            and not seenIDs[id] then

            seenIDs[id] = true
            table.insert(ids, id)
        end
    end

    addID(known[key])

    if #ids == 0 then
        pcall(function()
            local data = json(
                "https://en.wikipedia.org/w/api.php"
                .. "?action=query&format=json&redirects=1"
                .. "&prop=pageprops&ppprop=wikibase_item&titles="
                .. Http:UrlEncode(articles[key] or query)
            )

            for _, page in pairs(data.query and data.query.pages or {}) do
                if page.pageprops then
                    addID(page.pageprops.wikibase_item)
                end
            end
        end)
    end

    if #ids == 0 then
        local data = json(
            "https://www.wikidata.org/w/api.php"
            .. "?action=wbsearchentities&format=json"
            .. "&language=en&uselang=en&type=item&limit=10&search="
            .. Http:UrlEncode(query)
        )

        for _, hit in ipairs(data.search or {}) do
            local labelKey = normalize(hit.label or "")
            local matchKey = normalize(
                hit.match and hit.match.text or ""
            )

            if labelKey == key or matchKey == key then
                addID(hit.id)
            end
        end
    end

    assert(#ids > 0, "Brand not found")

    local data = json(
        "https://www.wikidata.org/w/api.php"
        .. "?action=wbgetentities&format=json&props=claims&ids="
        .. table.concat(ids, "|")
    )

    local logos, seen = {}, {}
    local ranks = {preferred = 1, normal = 2, deprecated = 3}

    for _, id in ipairs(ids) do
        local entity = data.entities and data.entities[id]
        local claims = entity and entity.claims
            and entity.claims.P154 or {}

        table.sort(claims, function(a, b)
            return (ranks[a.rank] or 2) < (ranks[b.rank] or 2)
        end)

        for _, claim in ipairs(claims) do
            local snak = claim.mainsnak
            local filename = snak and snak.datavalue
                and snak.datavalue.value

            if claim.rank ~= "deprecated"
                and type(filename) == "string"
                and not seen[filename] then

                seen[filename] = true
                table.insert(logos, {
                    filename = filename,
                    id = id,
                })
            end
        end
    end

    assert(#logos > 0, "No logo available")
    logoCache[key] = logos
    return logos
end

local function loadImage(candidate)
    local filename = candidate.filename

    if imageCache[filename] then
        return imageCache[filename]
    end

    local source =
        "https://commons.wikimedia.org/wiki/Special:FilePath/"
        .. Http:UrlEncode(filename) .. "?width=1000"

    local urls = {
        "https://images.weserv.nl/?url="
            .. Http:UrlEncode(source) .. "&output=png&w=1000",
        source,
    }

    local lastError = "Image unavailable"

    for _, url in ipairs(urls) do
        local ok, image = pcall(function()
            local body = get(url)

            assert(type(body) == "string"
                and body:sub(1, 8) == "\137PNG\r\n\26\n",
                "The service did not return a PNG image")

            local hash = 0
            for i = 1, #filename do
                hash = (hash * 31 + filename:byte(i)) % 2147483647
            end

            local path = "vantys2000_" .. candidate.id
                .. "_" .. tostring(hash) .. ".png"

            writefile(path, body)
            return assetFn(path)
        end)

        if ok then
            imageCache[filename] = image
            return image
        end

        lastError = tostring(image)
    end

    error(lastError)
end

local function showVariant(index, token)
    local candidate = variants[index]
    if not candidate then return end

    preview.Image = ""
    guide.Image = ""
    notice.Text = "Loading..."
    status.Text = "Version " .. index .. "/" .. #variants
    updateGuide()

    local ok, image = pcall(loadImage, candidate)

    if not alive or token ~= serial then return end

    if ok then
        preview.Image = image
        guide.Image = image
        notice.Text = ""
        status.Text = "Loaded · version "
            .. index .. "/" .. #variants
    else
        notice.Text = "Download failed. Try Next logo."
        status.Text = "Download error"
        warn("[Vantys] " .. tostring(image))
    end

    updateGuide()
end

local function loadLogo(query)
    serial += 1
    local token = serial

    current = query
    variants = {}
    variantIndex = 1
    logoTitle.Text = query
    preview.Image = ""
    guide.Image = ""
    notice.Text = "Searching..."
    status.Text = "Searching for logo"
    draggingGuide = false
    updateGuide()

    local ok, result = pcall(findLogos, query)

    if not alive or token ~= serial then return end

    if not ok then
        notice.Text = "Logo not found"
        status.Text = "Try the full brand name"
        warn("[Vantys] " .. tostring(result))
        return
    end

    variants = result
    showVariant(1, token)
end

local function manualSearch(query)
    query = query:match("^%s*(.-)%s*$")
    if query == "" then return end

    automatic = false
    autoButton.Text = "Auto: OFF"
    task.spawn(loadLogo, query)
end

button(main, "Search", 272, 0, 68, 28, function()
    manualSearch(search.Text)
end)

autoButton = button(main, "Auto: ON", 0, 192, 102, 30, function()
    automatic = not automatic
    autoButton.Text = automatic and "Auto: ON" or "Auto: OFF"

    if automatic and theme then
        local query = theme.Text:match("^(.-)|") or theme.Text
        task.spawn(loadLogo, query:match("^%s*(.-)%s*$"))
    end
end)

button(main, "Next logo", 110, 192, 102, 30, function()
    if #variants == 0 then return end

    variantIndex = variantIndex % #variants + 1
    serial += 1
    local token = serial
    task.spawn(showVariant, variantIndex, token)
end)

button(main, "Background", 220, 192, 120, 30, function()
    local dark = Color3.fromRGB(45, 45, 45)
    preview.BackgroundColor3 =
        preview.BackgroundColor3 == dark
        and Color3.fromRGB(150, 150, 150)
        or dark
end)

guideButton = button(main, "Guide: ON", 0, 230, 166, 32, function()
    guideEnabled = not guideEnabled
    draggingGuide = false
    updateGuide()
end)

moveButton = button(main, "Move guide: OFF", 174, 230, 166, 32, function()
    moveMode = not moveMode
    draggingGuide = false
    updateGuide()
end)

button(main, "Size −", 0, 270, 80, 28, function()
    config().scale = math.max(0.05, config().scale - 0.01)
    updateGuide()
end)

button(main, "Size +", 86, 270, 80, 28, function()
    config().scale = math.min(2, config().scale + 0.01)
    updateGuide()
end)

button(main, "Reset", 174, 270, 80, 28, function()
    draggingGuide = false
    positions[current] = {
        x = 0.5,
        y = 0.5,
        scale = 0.78125,
    }
    updateGuide()
end)

button(main, "Frame", 260, 270, 80, 28, function()
    outline.Enabled = not outline.Enabled
end)

button(main, "−", 0, 307, 36, 26, function()
    opacity = math.max(0.15, opacity - 0.10)
    updateGuide()
end)

opacityLabel = label(main, "", 42, 307, 256, 26)

button(main, "+", 304, 307, 36, 26, function()
    opacity = math.min(1, opacity + 0.10)
    updateGuide()
end)

label(main, "Drag the blue guide bar in Move mode.", 0, 342, 340, 26)

local function renderList()
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local query = normalize(search.Text)
    local matches = 0

    for _, brand in ipairs(brands) do
        if query == "" or normalize(brand):find(query, 1, true) then
            matches += 1
            local brandName = brand

            local item = button(list, brandName, 0, 0, 326, 25, function()
                search.Text = brandName
                manualSearch(brandName)
            end)

            item.LayoutOrder = matches
        end
    end

    catalogLabel.Text = "Catalog: " .. #brands
        .. "   |   Matches: " .. matches
    list.CanvasPosition = Vector2.zero
end

on(search:GetPropertyChangedSignal("Text"), renderList)

on(search.FocusLost, function(enter)
    if enter then manualSearch(search.Text) end
end)

-- Drag the main window.
on(titlebar.InputBegan, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingWindow = true
        draggingGuide = false
        dragStart = input.Position
        panelStart = window.Position
    end
end)

-- Drag the guide by its blue handle.
on(guideHandle.InputBegan, function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
        return
    end

    if not moveMode or not guideEnabled or not canvas then
        return
    end

    draggingGuide = true
    draggingWindow = false
    dragStart = input.Position

    local c = config()
    guideStart = Vector2.new(c.x, c.y)
end)

on(UIS.InputChanged, function(input)
    if input.UserInputType ~= Enum.UserInputType.MouseMovement then
        return
    end

    if draggingWindow and dragStart and panelStart then
        local delta = input.Position - dragStart

        window.Position = UDim2.new(
            panelStart.X.Scale,
            panelStart.X.Offset + delta.X,
            panelStart.Y.Scale,
            panelStart.Y.Offset + delta.Y
        )

    elseif draggingGuide and dragStart and guideStart and canvas then
        local size = canvas.AbsoluteSize

        if size.X > 0 and size.Y > 0 then
            local delta = input.Position - dragStart
            local c = config()

            c.x = guideStart.X + delta.X / size.X
            c.y = guideStart.Y + delta.Y / size.Y

            updateGuide()
        end
    end
end)

local function releaseDrag()
    draggingWindow = false
    draggingGuide = false
end

on(UIS.InputEnded, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        releaseDrag()
    end
end)

on(UIS.WindowFocusReleased, releaseDrag)

on(UIS.InputBegan, function(input, processed)
    if processed or UIS:GetFocusedTextBox() then return end

    local c = config()
    local step = UIS:IsKeyDown(Enum.KeyCode.LeftShift)
        and 0.01 or 0.002

    local key = input.KeyCode

    if key == Enum.KeyCode.Left then
        c.x -= step
    elseif key == Enum.KeyCode.Right then
        c.x += step
    elseif key == Enum.KeyCode.Up then
        c.y -= step
    elseif key == Enum.KeyCode.Down then
        c.y += step
    elseif key == Enum.KeyCode.H then
        guideEnabled = not guideEnabled
        draggingGuide = false
    end

    updateGuide()
end)

renderList()
updateGuide()

task.spawn(function()
    local previousRoot
    local previousQuery = ""

    while alive do
        local gameplay = pg:FindFirstChild("Gameplay")
        local candidate = gameplay and gameplay:FindFirstChild("minigame")

        root = candidate
        canvas = candidate and candidate:FindFirstChild("canvas")
        theme = candidate and candidate:FindFirstChild("theme")

        if root ~= previousRoot then
            previousRoot = root
            previousQuery = ""
            draggingGuide = false
        end

        if root and canvas and theme then
            local query = theme.Text:match("^(.-)|") or theme.Text
            query = query:match("^%s*(.-)%s*$")

            if query ~= previousQuery then
                previousQuery = query

                if automatic and query ~= "" then
                    task.spawn(loadLogo, query)
                end
            end
        end

        updateGuide()
        task.wait(0.1)
    end
end)