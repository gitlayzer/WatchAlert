INSERT INTO `notice_template_examples` (`id`, `name`, `description`, `template`) VALUES ('nt-cn25c0radq75sf2v1hf0', '通用告警/恢复模版', '通用告警/恢复模版', '{{- define \"Title\" -}}\n{{- if not .IsRecovered -}}\n【报警中】- 即时设计业务系统 🔥\n{{- else -}}\n【已恢复】- 即时设计业务系统 ✨\n{{- end -}}\n{{- end }}\n\n{{- define \"TitleColor\" -}}\n{{- if not .IsRecovered -}}\nred\n{{- else -}}\ngreen\n{{- end -}}\n{{- end }}\n\n{{ define \"Event\" -}}\n{{- if not .IsRecovered -}}\n**🤖 报警类型:** ${rule_name}\n**🫧 报警指纹:** ${fingerprint}\n**📌 报警等级:** P${severity}\n**🖥 报警主机:** ${metric.instance}\n**🕘 开始时间:** ${first_trigger_time_format}\n**👤 值班人员:** ${duty_user}\n**📝 报警事件:** ${annotations}\n{{- else -}}\n**🤖 报警类型:** ${rule_name}\n**🫧 报警指纹:** ${fingerprint}\n**📌 报警等级:** P${severity}\n**🖥 报警主机:** ${metric.instance}\n**🕘 开始时间:** ${first_trigger_time_format}\n**🕘 恢复时间:** ${recover_time_format}\n**👤 值班人员:** ${duty_user}\n**📝 报警事件:** ${annotations}\n{{- end -}}\n{{ end }}\n\n{{- define \"Footer\" -}}\n🧑‍💻 即时设计 - 运维团队\n{{- end }}');
INSERT INTO `notice_template_examples` (`id`, `name`, `description`, `template`) VALUES ('nt-cn25cabadq75sf2v1hfg', '飞书高级卡片消息Json（告警）', '飞书高级卡片消息Json（告警）', '{\n  \"elements\": [\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🫧 报警指纹：**\\n${fingerprint}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        },\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🤖 报警类型：**\\n${rule_name}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**📌 报警等级：**\\nP${severity}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        },\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🕘 开始时间：**\\n${first_trigger_time_format}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**👤 值班人员：**\\n${duty_user}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        },\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🖥 报警主机：**\\n${metric.instance}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**📝 报警事件：**\\n${annotations}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"hr\",\n      \"flexMode\": \"\",\n      \"background_style\": \"\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": null,\n      \"elements\": null\n    },\n    {\n      \"tag\": \"note\",\n      \"flexMode\": \"\",\n      \"background_style\": \"\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": null,\n      \"elements\": [\n        {\n          \"tag\": \"plain_text\",\n          \"content\": \"🧑‍💻 即时设计 - 运维团队\"\n        }\n      ]\n    }\n  ],\n  \"header\": {\n    \"template\": \"red\",\n    \"title\": {\n      \"content\": \"【报警中】- 即时设计业务系统 🔥\",\n      \"tag\": \"plain_text\"\n    }\n  },\n  \"tag\": \"\"\n}');
INSERT INTO `notice_template_examples` (`id`, `name`, `description`, `template`) VALUES ('nt-cn25cf3adq75sf2v1hg0', '飞书高级卡片消息Json（恢复）', '飞书高级卡片消息Json（恢复）', '{\n  \"elements\": [\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🫧 报警指纹：**\\n${fingerprint}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        },\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🤖 报警类型：**\\n${rule_name}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**📌 报警等级：**\\nP${severity}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        },\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🕘 开始时间：**\\n${first_trigger_time_format}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🕘 恢复时间：**\\n${recover_time_format}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        },\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**🖥 报警主机：**\\n${metric.instance}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**👤 值班人员：**\\n${duty_user}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"column_set\",\n      \"flexMode\": \"none\",\n      \"background_style\": \"default\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": [\n        {\n          \"tag\": \"column\",\n          \"width\": \"weighted\",\n          \"weight\": 1,\n          \"vertical_align\": \"top\",\n          \"elements\": [\n            {\n              \"tag\": \"div\",\n              \"text\": {\n                \"content\": \"**📝 报警事件：**\\n${annotations}\",\n                \"tag\": \"lark_md\"\n              }\n            }\n          ]\n        }\n      ],\n      \"elements\": null\n    },\n    {\n      \"tag\": \"hr\",\n      \"flexMode\": \"\",\n      \"background_style\": \"\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": null,\n      \"elements\": null\n    },\n    {\n      \"tag\": \"note\",\n      \"flexMode\": \"\",\n      \"background_style\": \"\",\n      \"text\": {\n        \"content\": \"\",\n        \"tag\": \"\"\n      },\n      \"actions\": null,\n      \"columns\": null,\n      \"elements\": [\n        {\n          \"tag\": \"plain_text\",\n          \"content\": \"🧑‍💻 即时设计 - 运维团队\"\n        }\n      ]\n    }\n  ],\n  \"header\": {\n    \"template\": \"green\",\n    \"title\": {\n      \"content\": \"【已恢复】- 即时设计业务系统 ✨\",\n      \"tag\": \"plain_text\"\n    }\n  },\n  \"tag\": \"\"\n}');
INSERT INTO `notice_template_examples` (`id`, `name`, `description`, `template`) VALUES ('nt-cngrdfjadq74gki6a43g', '阿里SLS-服务错误日志告警/恢复模版示例', '阿里SLS-服务错误日志告警/恢复模版示例', '{{- define \"Title\" -}}\n{{- if not .IsRecovered -}}\n【报警中】- 即时设计业务系统 🔥\n{{- else -}}\n【已恢复】- 即时设计业务系统 ✨\n{{- end -}}\n{{- end }}\n\n{{- define \"TitleColor\" -}}\n{{- if not .IsRecovered -}}\nred\n{{- else -}}\ngreen\n{{- end -}}\n{{- end }}\n\n{{ define \"Event\" -}}\n{{- if not .IsRecovered -}}\n**🤖 报警类型:** ${rule_name}\n**🫧 报警指纹:** ${fingerprint}\n**📌 报警等级:** P${severity}\n**🖥 报警主机:** ${metric.__tag__:_node_name_}\n**🧚 容器名称:** ${metric._pod_name_}\n**☘️ 业务环境:** ${metric._namespace_}\n**🕘 开始时间:** ${first_trigger_time_format}\n**👤 值班人员:** ${duty_user}\n**📝 报警事件:** ${annotations.content}\n{{- else -}}\n**🤖 报警类型:** ${rule_name}\n**🫧 报警指纹:** ${fingerprint}\n**📌 报警等级:** P${severity}\n**🖥 报警主机:** ${metric.__tag__:_node_name_}\n**🧚 容器名称:** ${metric._pod_name_}\n**☘️ 业务环境:** ${metric._namespace_}\n**🕘 开始时间:** ${first_trigger_time_format}\n**🕘 恢复时间:** ${recover_time_format}\n**👤 值班人员:** ${duty_user}\n**📝 报警事件:** ${annotations.content}\n{{- end -}}\n{{ end }}\n\n{{- define \"Footer\" -}}\n🧑‍💻 即时设计 - 运维团队\n{{- end }}');
INSERT INTO `notice_template_examples` (`id`, `name`, `description`, `template`) VALUES ('nt-cnk0lbbadq7djalsvom0', 'Loki-服务错误日志告警/恢复示例', 'Loki-服务错误日志告警/恢复示例', '{{- define \"Title\" -}}\n{{- if not .IsRecovered -}}\n【报警中】- 即时设计业务系统 🔥\n{{- else -}}\n【已恢复】- 即时设计业务系统 ✨\n{{- end -}}\n{{- end }}\n\n{{- define \"TitleColor\" -}}\n{{- if not .IsRecovered -}}\nred\n{{- else -}}\ngreen\n{{- end -}}\n{{- end }}\n\n{{ define \"Event\" -}}\n{{- if not .IsRecovered -}}\n**🤖 报警类型:** ${rule_name}\n**🫧 报警指纹:** ${fingerprint}\n**📌 报警等级:** P${severity}\n**🖥 报警主机:** ${metric.node_name}\n**🧚 容器名称:** ${metric.pod}\n**☘️ 业务环境:** ${metric.namespace}\n**🕘 开始时间:** ${first_trigger_time_format}\n**👤 值班人员:** ${duty_user}\n**📝 报警事件:** ${annotations}\n{{- else -}}\n**🤖 报警类型:** ${rule_name}\n**🫧 报警指纹:** ${fingerprint}\n**📌 报警等级:** P${severity}\n**🖥 报警主机:** ${metric.node_name}\n**🧚 容器名称:** ${metric.pod}\n**☘️ 业务环境:** ${metric.namespace}\n**🕘 开始时间:** ${first_trigger_time_format}\n**🕘 恢复时间:** ${recover_time_format}\n**👤 值班人员:** ${duty_user}\n**📝 报警事件:** ${annotations}\n{{- end -}}\n{{ end }}\n\n{{- define \"Footer\" -}}\n🧑‍💻 即时设计 - 运维团队\n{{- end }}');
INSERT INTO `watchalert`.`notice_template_examples` (`id`,`name`,`description`,`template`) VALUES ('nt-cq7lsbpd6gvng999331g','Email邮件告警/恢复通知示例','Email邮件告警/恢复通知示例','{{ define "Event" -}}
{{- if not .IsRecovered -}}
<p>==========<strong>告警通知</strong>==========</p>
<strong>🤖 报警类型:</strong> ${rule_name}<br>
<strong>🫧 报警指纹:</strong> ${fingerprint}<br>
<strong>📌 报警等级:</strong> ${severity}<br>
<strong>🖥 报警主机:</strong> ${metric.node_name}<br>
<strong>🧚 容器名称:</strong> ${metric.pod}<br>
<strong>☘️ 业务环境:</strong> ${metric.namespace}<br>
<strong>🕘 开始时间:</strong> ${first_trigger_time_format}<br>
<strong>👤 值班人员:</strong> ${duty_user}<br>
<strong>📝 报警事件:</strong> ${annotations}<br>
{{- else -}}
<p>==========<strong>恢复通知</strong>==========</p>
<strong>🤖 报警类型:</strong> ${rule_name}<br>
<strong>🫧 报警指纹:</strong> ${fingerprint}<br>
<strong>📌 报警等级:</strong> ${severity}<br>
<strong>🖥 报警主机:</strong> ${metric.node_name}<br>
<strong>🧚 容器名称:</strong> ${metric.pod}<br>
<strong>☘️ 业务环境:</strong> ${metric.namespace}<br>
<strong>🕘 开始时间:</strong> ${first_trigger_time_format}<br>
<strong>🕘 恢复时间:</strong> ${recover_time_format}<br>
<strong>👤 值班人员:</strong> ${duty_user}<br>
<strong>📝 报警事件:</strong> ${annotations}<br>
{{- end -}}
{{ end }}');
