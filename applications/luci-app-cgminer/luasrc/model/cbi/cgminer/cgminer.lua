require("luci.util")

m = Map("cgminer", translate("Configuration"),
        translate("Please visit <a href='https://canaan.io/support/'> https://canaan.io/support/</a> for support."))

conf = m:section(TypedSection, "cgminer", "")
conf.anonymous = true
conf.addremove = false

ntp = conf:option(ListValue, "ntp_enable", translate("NTP Service(Default: Disable)"))
ntp.default = "disable"
ntp:value("asia", translate("ASIA"))
ntp:value("openwrt", translate("OpenWrt Default"))
ntp:value("disable", translate("Disable"))

pool1url = conf:option(Value, "pool1url", translate("Pool 1"))
pool1url.datatype = "string"
pool1url:value("stratum+tcp://stratum.kano.is:3333")
pool1url:value("stratum+tcp://stratum.haobtc.com:3333")
pool1user = conf:option(Value, "pool1user", translate("Pool1 worker"))
pool1pw = conf:option(Value, "pool1pw", translate("Pool1 password"))
pool2url = conf:option(Value, "pool2url", translate("Pool 2"))
pool2url.datatype = "string"
pool2url:value("stratum+tcp://stratum80.kano.is:80")
pool2url:value("stratum+tcp://stratum.haobtc.com:443")
pool2user = conf:option(Value, "pool2user", translate("Pool2 worker"))
pool2pw = conf:option(Value, "pool2pw", translate("Pool2 password"))
pool3url = conf:option(Value, "pool3url", translate("Pool 3"))
pool3url.datatype = "string"
pool3url:value("stratum+tcp://stratum80.kano.is:81")
pool3url:value("stratum+tcp://stratum.haobtc.com:25")
pool3user = conf:option(Value, "pool3user", translate("Pool3 worker"))
pool3pw = conf:option(Value, "pool3pw", translate("Pool3 password"))

vo = conf:option(ListValue, "voltage_level_offset", translate("Voltage Level Offset(Default: 0)"))
vo.default = "0"
vo:value("+1", translate("+1"))
vo:value("-1", translate("-1"))
vo:value("-2", translate("-2"))
vo:value("0", translate("0"))

fan = conf:option(Value, "fan", translate("Minimum Fan%(Range: 0-100, Default: 10%)"))
fan.datatype = "range(0, 100)"

local boardinfo = luci.util.ubus("system", "board") or { }
if (boardinfo.model == "Canaan Z Controller") then
	ssp = conf:option(ListValue, "ssp", translate("SmartSpeed+(Default: Disable)"))
	ssp.default = "disable"
	ssp:value("enable", translate("Enable"))
	ssp:value("disable", translate("Disable"))
end

api_allow = conf:option(Value, "api_allow", translate("API Allow(Default: W:127.0.0.1)"))

power_mode = conf:option(ListValue, "power_mode", translate("Power Mode(Default: Normal, Support: A8)"))
power_mode.default = "normal"
power_mode:value("normal", translate("Normal"))
power_mode:value("low", translate("Low"))

more_options = conf:option(Value, "more_options", translate("More Options"))

return m
