package com.example.flutterhud

import android.content.Context
import android.net.wifi.WifiManager
import android.text.format.Formatter
import java.net.NetworkInterface
import java.net.NetworkInterface.getNetworkInterfaces
import java.util.*


class IpAddress {
    fun getWifiIp(context: Context): String {
        val wifiMgr = context.applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        val wifiInfo = wifiMgr.connectionInfo
        var ip = wifiInfo.ssid

        ip += Formatter.formatIpAddress(wifiInfo.ipAddress)

        return ip;

    }

    fun getMobileIp(context: Context): String {

        return getIPAddress(true)

    }

    /**
     * Credit https://stackoverflow.com/questions/6064510/how-to-get-ip-address-of-the-device-from-code
     * Get IP address from first non-localhost interface
     * @param ipv4  true=return ipv4, false=return ipv6
     * @return  address or empty string
     */
    fun getIPAddress(useIPv4: Boolean): String {

        val buf = StringBuffer()
        try {
            val interfaces = Collections.list(NetworkInterface.getNetworkInterfaces())
            for (intf in interfaces) {
                val addrs = Collections.list(intf.getInetAddresses())
                for (addr in addrs) {
                    if (!addr.isLoopbackAddress()) {
                        val sAddr = addr.getHostAddress()
//                        boolean isIPv4 = InetAddressUtils.isIPv4Address(sAddr);
                        val isIPv4 = sAddr.indexOf(':') < 0

                        if (useIPv4) {
                            if (isIPv4)
//                                return sAddr
                                buf.append(" $sAddr")
                        } else {
                            if (!isIPv4) {
                                val delim = sAddr.indexOf('%') // drop ip6 zone suffix
                                val addr = if (delim < 0) sAddr.toUpperCase() else sAddr.substring(0, delim).toUpperCase()
                                buf.append(" $addr")
                            }
                        }
                    }
                }
            }
        } catch (ex: Exception) {
        }
        // for now eat exceptions
        return buf.toString()
    }

}