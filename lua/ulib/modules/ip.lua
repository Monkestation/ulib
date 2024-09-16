if (SERVER) then
	util.AddNetworkString( "ulib_requestPlayerIP" )
	util.AddNetworkString("ulib_receivePlayerIP")

	-- Incoming: DataPresent-int, independentId-int,
	net.Receive( "ulib_requestPlayerIP", function( len, ply )
		print("recieved thingy!")
		local access, accessTag = ULib.ucl.query( ply, "ulx banip" )
		local requestTangent = net.ReadString()

		if not access then
			ULib.tsayError("Unable to request IP. No Access.")
			net.Start("ulib_receivePlayerIP")
				net.WriteInt(0)
				net.WriteString(requestTangent)
			net.Send(ply)
			return
		end

		local targetPlayer = net.ReadPlayer()

		local playerIP = targetPlayer:IPAddress()

		print(playerIP, targetPlayer)
		net.Start("ulib_receivePlayerIP")
			net.WriteInt(1,1)
			net.WriteString(requestTangent)
			net.WritePlayer(targetPlayer)
			net.WriteString(playerIP)
		net.Send(ply)

	end)
end

