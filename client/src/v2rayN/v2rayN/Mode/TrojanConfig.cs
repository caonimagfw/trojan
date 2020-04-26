using System;
using System.Collections.Generic;

namespace v2rayN.Mode
{
    /// <summary>
    /// v2ray配置文件实体类
    /// 例子SampleConfig.txt
    /// </summary>

    public class TrojanConfig
    {
        public string run_type
        {
            get;
            set;
        }

        public string local_addr
        {
            get;
            set;
        }

        public int local_port
        {
            get;
            set;
        }

        public string remote_addr
        {
            get;
            set;
        }

        public int remote_port
        {
            get;
            set;
        }

        public List<string> password
        {
            get;
            set;
        }

        public bool append_payload
        {
            get;
            set;
        }

        public int log_level
        {
            get;
            set;
        }

        public Ssl ssl
        {
            get;
            set;
        }

        public Tcp tcp
        {
            get;
            set;
        }
    }

    public class Ssl
    {
        // Token: 0x17000076 RID: 118
        // (get) Token: 0x060000E4 RID: 228 RVA: 0x00003CB3 File Offset: 0x00001EB3
        // (set) Token: 0x060000E5 RID: 229 RVA: 0x00003CBB File Offset: 0x00001EBB
        public bool verify { get; set; }

        // Token: 0x17000077 RID: 119
        // (get) Token: 0x060000E6 RID: 230 RVA: 0x00003CC4 File Offset: 0x00001EC4
        // (set) Token: 0x060000E7 RID: 231 RVA: 0x00003CCC File Offset: 0x00001ECC
        public bool verify_hostname { get; set; }

        // Token: 0x17000078 RID: 120
        // (get) Token: 0x060000E8 RID: 232 RVA: 0x00003CD5 File Offset: 0x00001ED5
        // (set) Token: 0x060000E9 RID: 233 RVA: 0x00003CDD File Offset: 0x00001EDD
        public string cert { get; set; }

        // Token: 0x17000079 RID: 121
        // (get) Token: 0x060000EA RID: 234 RVA: 0x00003CE6 File Offset: 0x00001EE6
        // (set) Token: 0x060000EB RID: 235 RVA: 0x00003CEE File Offset: 0x00001EEE
        public string cipher { get; set; }

        // Token: 0x1700007A RID: 122
        // (get) Token: 0x060000EC RID: 236 RVA: 0x00003CF7 File Offset: 0x00001EF7
        // (set) Token: 0x060000ED RID: 237 RVA: 0x00003CFF File Offset: 0x00001EFF
        public string sni { get; set; }

        // Token: 0x1700007B RID: 123
        // (get) Token: 0x060000EE RID: 238 RVA: 0x00003D08 File Offset: 0x00001F08
        // (set) Token: 0x060000EF RID: 239 RVA: 0x00003D10 File Offset: 0x00001F10
        public List<string> alpn { get; set; }

        // Token: 0x1700007C RID: 124
        // (get) Token: 0x060000F0 RID: 240 RVA: 0x00003D19 File Offset: 0x00001F19
        // (set) Token: 0x060000F1 RID: 241 RVA: 0x00003D21 File Offset: 0x00001F21
        public bool reuse_session { get; set; }

        // Token: 0x1700007D RID: 125
        // (get) Token: 0x060000F2 RID: 242 RVA: 0x00003D2A File Offset: 0x00001F2A
        // (set) Token: 0x060000F3 RID: 243 RVA: 0x00003D32 File Offset: 0x00001F32
        public bool session_ticket { get; set; }

        // Token: 0x1700007E RID: 126
        // (get) Token: 0x060000F4 RID: 244 RVA: 0x00003D3B File Offset: 0x00001F3B
        // (set) Token: 0x060000F5 RID: 245 RVA: 0x00003D43 File Offset: 0x00001F43
        public string curves { get; set; }
    }
    // Token: 0x0200001A RID: 26
    public class Tcp
    {
        // Token: 0x1700007F RID: 127
        // (get) Token: 0x060000F7 RID: 247 RVA: 0x00003D4C File Offset: 0x00001F4C
        // (set) Token: 0x060000F8 RID: 248 RVA: 0x00003D54 File Offset: 0x00001F54
        public bool no_delay { get; set; }

        // Token: 0x17000080 RID: 128
        // (get) Token: 0x060000F9 RID: 249 RVA: 0x00003D5D File Offset: 0x00001F5D
        // (set) Token: 0x060000FA RID: 250 RVA: 0x00003D65 File Offset: 0x00001F65
        public bool keep_alive { get; set; }

        // Token: 0x17000081 RID: 129
        // (get) Token: 0x060000FB RID: 251 RVA: 0x00003D6E File Offset: 0x00001F6E
        // (set) Token: 0x060000FC RID: 252 RVA: 0x00003D76 File Offset: 0x00001F76
        public bool fast_open { get; set; }

        // Token: 0x17000082 RID: 130
        // (get) Token: 0x060000FD RID: 253 RVA: 0x00003D7F File Offset: 0x00001F7F
        // (set) Token: 0x060000FE RID: 254 RVA: 0x00003D87 File Offset: 0x00001F87
        public int fast_open_qlen { get; set; }
    }
}
