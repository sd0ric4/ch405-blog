import { firefox } from "./firefox/firefox.mts"
import { novnc } from "./novnc/novnc.mts"
import { ubuntu } from "./ubuntu/ubuntu.mts"
import { kasm } from "./kasm/kasm.mts"
export const servic_outsourcing = [
    {
        text: '镜像',
        items: [
            firefox,
            novnc,
            ubuntu,
            kasm
        ]
    },
]