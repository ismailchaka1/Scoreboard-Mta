local sx,sy = guiGetScreenSize()
local x, y = (sx/1366), (sy/768) 
local scoreboard = false
local font = dxCreateFont("files/font.ttf", 33)
local font2 = dxCreateFont("files/font.ttf", 11)
local scrollCache = 0
local maxPlayersInTab = 10
local allPlayer = 0
local ScoreTable = {}


function DrawScoreboard()
    if (scoreboard) then
		ScoreTable = {}
		for k, v in ipairs(getElementsByType("player")) do
			ScoreTable[#ScoreTable + 1] = v
		end
        Admins = 0
        for i, v in pairs(getElementsByType("player")) do 
            if getElementData(v, "duty_admin") == 1  then
                if exports.integration:isPlayerTrialAdmin(v) or exports.integration:isPlayerAdmin(v) or exports.integration:isPlayerSeniorAdmin(v) or exports.integration:isPlayerLeadAdmin(v) then 
                    Admins = Admins + 1 
                end
            end
        end
        supports = 0
        for i, k in pairs(getElementsByType("player")) do 
            if getElementData(k, "duty_supporter") == 1  then
                if exports.integration:isPlayerSupporter(k) then 
                    supports = supports + 1 
                end
            end
        end
        dxDrawRectangle(x*198, y*49, x*1001, y*151, tocolor(0, 0, 0, 120), false)
        dxDrawRectangle(x*885, y*220, x*314, y*449, tocolor(0, 0, 0, 120), false)
        dxDrawRectangle(x*206, y*220, x*670, y*35, tocolor(0,0,0, 120), false)
        dxDrawRectangle(x*198, y*220, x*5, y*456, tocolor(0, 0, 0, 120), false)
        dxDrawImage(x*911, y*237, x*264, y*19, ":scoreboard/img/hk_score_sever_infos.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*911, y*457, x*264, y*19, ":scoreboard/img/hk_score_second_infos.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*1088, y*494, x*84, y*78, ":account/img/"..getElementModel(localPlayer)..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawImage(x*1086, y*491, x*89, y*82, ":scoreboard/img/hk_score_cdr.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*886, y*220, x*313, y*448, ":scoreboard/img/hk_infos_lines.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*199, y*50, x*1000, y*150, ":scoreboard/img/hk_score_head.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawText("الايدي",x* 777, y*226, x*858, y*247, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("الاسم", x*656, y*226, x*737, y*247, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("عدد ساعات اللعب", x*461, y*226, x*542,y* 247, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Ping", x*273, y*226, x*354, y*247, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("نسخة سيرفر", x*948, y*266, x*1136, y*288, tocolor(255,255,255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("3.0.0", x*948, y*270, x*1136, y*320, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("مدينة لعب سيرفر", x*948, y*290, x*1136, y*360, tocolor(255,255,255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("Los Santos", x*948, y*295, x*1136, y*392, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("عدد المشرفين (في الخدمة)", x*948, y*385, x*1136, y*360, tocolor(255,255,255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText(""..Admins.." Admin", x*948, y*425, x*1136, y*360, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText("عدد المساعدين (في الخدمة)", x*948, y*480, x*1136, y*360, tocolor(255,255,255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText(""..supports.." Supporter", x*948, y*520, x*1136, y*360, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
		allPlayers = 0
        local offsetY = 0
        local offsetText = 0
        latestLine = onlinePlayer + maxPlayersInTab
		for i, t in pairs(getElementsByType("player")) do
            allPlayers = allPlayers + 1
            if i >= onlinePlayer and i <= latestLine then
                local posY = offsetY - scrollCache
                local posText = offsetY - scrollCache
                dxDrawRectangle(x*206, y*(260+posY), x*670, y*35, tocolor(0, 0, 0, 120))
                dxDrawImage(x*858, y*(262+posY), x*17, y*30, "img/hk_score_line.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        
                dxDrawText(getElementData(t,"playerid"), x*796, y*(262+posText*2), x*831, y*292, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
                dxDrawText(getPlayerName(t), x*590, y*(262+posText*2), x*831, y*292, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)

                dxDrawText(getElementData(t, "hoursplayed") or 0, x*460, y*(262+posText*2), x*550, y*292, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
                dxDrawText(getPlayerPing(t), x*90, y*(262+posText*2), x*550, y*292, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
                offsetY = offsetY + 40
                allPlayer = allPlayers
            end
		end
        dxDrawText(""..allPlayers.." / 100", x*1050, y*125, x*1153, y*128, tocolor(254,207,2, 255), 1.00, font, "center", "center", false, false, false, false, false)
        dxDrawText("الاسم كامل", x*910, y*491, x*1082, y*513, tocolor(255, 255, 255, 255), 1.00, font2, "right", "top", false, false, false, false, false)
        dxDrawText(getPlayerName(localPlayer), x*910, y*507, x*1082, y*513, tocolor(254,207,2, 255), 1.00, font2, "right", "top", false, false, false, false, false)
        dxDrawText("المال في المحفظة", x*910, y*530, x*1082, y*513, tocolor(255, 255, 255, 255), 1.00, font2, "right", "top", false, false, false, false, false)
        dxDrawText(""..getElementData(localPlayer,"money").." $", x*910, y*550, x*1082, y*513, tocolor(254,207,2, 255), 1.00, font2, "right", "top", false, false, false, false, false)
        dxDrawText("اسم حسابك", x*1084, y*591, x*1176, y*609, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        dxDrawText(getElementData(localPlayer,"account:username"), x*1084, y*609, x*1176,y* 627, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        --dxDrawText("", x*933, y*609, x*1025, y*627, tocolor(254,207,2, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        --dxDrawText("البريد الاكتروني", x*933, y*591, x*1025, y*609, tocolor(255, 255, 255, 255), 1.00, font2, "center", "center", false, false, false, false, false)
        if allPlayer >= 1 then 
            -- dxDrawRectangle(sx*180, scoreBarPos[2]+75+((panelHeight)/(allPlayer-maxDraw+50))*scrolling, sx*5, sy*4, tocolor(207,180,63, 255), false)
            dxDrawRectangle(x*198, y*250-y*40/(allPlayer-maxPlayersInTab)+10*onlinePlayer, x*5, y*5, tocolor(207,180,63, 255), false)
        end
    end
end
addEventHandler("onClientRender", root, DrawScoreboard)
function updateBars()
	activePlayer = 0
	onlinePlayer = 1
	for k, client in pairs(getElementsByType("player")) do
        activePlayer = activePlayer+1
	end
end
bindKey("tab", "down", function()
    if (getElementData(localPlayer,"loggedin") == 1) then
        scoreboard = true
        updateBars()
    end
end)
bindKey("tab", "up", function()
    if (getElementData(localPlayer,"loggedin") == 1) then
        scoreboard = false
    end
end)

bindKey("mouse_wheel_down", "down",
	function()
		if (scoreboard) then
			if (onlinePlayer <= (#ScoreTable) - maxPlayersInTab) then
				onlinePlayer = onlinePlayer + 1
			end
		end
	end
)

bindKey("mouse_wheel_up", "down",
	function()
		if (scoreboard) then
			if (onlinePlayer > 1) then
				onlinePlayer = onlinePlayer - 1
			end	
		end
	end
)