// school_knowledge.mts
import { computer_organization } from "./school_knowledge/computer_organization/computer_organization.mts"
import { cpp_docs } from "./school_knowledge/c_plus_plus/cpp.mts"
export const school_knowledge = [
    {
        text: 'school_knowledge',
        items: [
            //{text:'C语言',link:'/school_knowledge/C语言.md'},
            {
                text:'C++',
                link:'/school_knowledge/C++.md',
                items: cpp_docs
            },
            //{text:'Java',link:'/school_knowledge/Java.md',},
            {
                text:'计算机组成原理',
                link:'/school_knowledge/计算机组成原理.md',
                items: computer_organization
            },
            //{text:'Python',link:'/school_knowledge/Python.md'},
            //{text:'Linux',link:'/school_knowledge/Linux.md'},
            //{text:'计算机网络',link:'/school_knowledge/计算机网络.md'},
            //{text:'数据结构',link:'/school_knowledge/数据结构.md'},
            //{text:'算法',link:'/school_knowledge/算法.md'},
            //{text:'数据库',link:'/school_knowledge/数据库.md'},
            //{text:'Web安全',link:'/school_knowledge/Web安全.md'},
            //{text:'Web开发',link:'/school_knowledge/Web开发.md'},
            //{text:'Web框架',link:'/school_knowledge/Web框架.md'},
            //{text:'Web服务器',link:'/school_knowledge/Web服务器.md'},
            //{text:'Web渗透',link:'/school_knowledge/Web渗透.md'},
            //{text:'Web应用',link:'/school_knowledge/Web应用.md'},
            //{text:'Web漏洞',link:'/school_knowledge/Web漏洞.md'},
        ]
    },
]