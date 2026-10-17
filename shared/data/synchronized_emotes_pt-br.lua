return {
{
        Label = 'Baseball',
        Command = 'sbaseball',
        Animation = 'baseball_a_player_a',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Shared = {
                OtherAnimation = 'sbaseballthrow',
            },
        },
    },
    {
        Label = 'Lançamento de Baseball',
        Command = 'lbaseball',
        Animation = 'baseball_a_player_b',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Shared = {
                OtherAnimation = 'sbaseball',
            },
        },
    },
    {
        Label = 'Refem',
        Command = 'refem',
        Animation = 'victim_idle',
        Dictionary = 'anim@gangops@hostage@',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                OtherAnimation = 'shostage',
                Placement = {
                    vector3(-0.300000, 0.100000, 0.000000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Revistar 2',
        Command = 'revistar2',
        Animation = 'a2_pose',
        Dictionary = 'missfam5_yoga',
        Options = {
            Flags = {
                Move = true,
            },
            Shared = {
                Attach = true,
                OtherAnimation = 'ssearch',
                Placement = {
                    vector3(0.000000, 0.500000, 0.000000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Carregar Cachorro Grande',
        Command = 'ccachorrog',
        Animation = 'sleep_in_kennel',
        Dictionary = 'creatures@rottweiler@amb@sleep_in_kennel@',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                OtherAnimation = 'scbdog',
                Placement = {
                    vector3(-0.100000, 0.650000, 0.430000),
                    vector3(0.000000, 0.000000, -100.000000),
                },
            },
        },
    },
    {
        Label = 'Cumprimentar',
        Command = 'cumprimentar',
        Animation = 'hugs_guy_a',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Shared = {
                FrontOffset = 1.14,
                OtherAnimation = 'sbro2',
            },
        },
    },
    {
        Label = 'Cumprimentar 2',
        Command = 'cumprimentar2',
        Animation = 'hugs_guy_b',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Shared = {
                FrontOffset = 1.14,
                OtherAnimation = 'sbro',
            },
        },
    },
    {
        Label = 'Carregar',
        Command = 'carregar',
        Animation = 'firemans_carry',
        Dictionary = 'nm',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 40269,
                OtherAnimation = 'scarry',
                Placement = {
                    vector3(-0.140000, 0.150000, 0.140000),
                    vector3(0.000000, -59.000000, -4.500000),
                },
            },
        },
    },
    {
        Label = 'Carregar 2',
        Command = 'carregar2',
        Animation = 'base',
        Dictionary = 'amb@code_human_in_car_idles@generic@ps@base',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 28252,
                OtherAnimation = 'carry2',
                Placement = {
                    vector3(0.350000, 0.150000, -0.150000),
                    vector3(-42.500000, -22.500000, 22.500000),
                },
            },
        },
    },
    {
        Label = 'Carregar 3',
        Command = 'carregar3',
        Animation = 'couplepose2cmg_clip',
        Dictionary = 'couplepose2cmg@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'scarry3',
                Placement = {
                    vector3(0.010000, 0.344000, -0.010000),
                    vector3(180.000000, 180.000000, -1.999900),
                },
            },
        },
    },
    {
        Label = 'Carregar 4',
        Command = 'carregar4',
        Animation = 'fin_c2_mcs_1_camman',
        Dictionary = 'missfinale_c2mcs_1',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'scarried',
            },
        },
        SkipRequest = true
    },
    {
        Label = 'Carregar 5',
        Command = 'carregar5',
        Animation = 'idle',
        Dictionary = 'anim@heists@box_carry@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                Bone = 40269,
                OtherAnimation = 'scarried2',
            },
        },
        SkipRequest = true
    },
    {
        Label = 'Carregar 6',
        Command = 'carregar6',
        Animation = 'couplepose1cmg_clip',
        Dictionary = 'couplepose1cmg@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'carried3',
            },
        },
    },
    {
        Label = 'Carregar Cachorro Grande',
        Command = 'ccgrande',
        Animation = 'idle',
        Dictionary = 'anim@heists@box_carry@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'scbdog2',
            },
        },
    },
    {
        Label = 'Tomar um Drink Masculino',
        Command = 'tdrinkm',
        Animation = 'action_var_01_bank_manager',
        Dictionary = 'anim@scripted@robbery@tun_prep_uni_ig1_couple@',
        Options = {
            Flags = {
                Loop = true,
            },
            Props = {
                {
                    Bone = 60309,
                    Name = 'p_wine_glass_s',
                    Placement = {
                        vector3(-0.050000, -0.010000, -0.170000),
                        vector3(0.000000, 0.000000, 0.000000),
                    },
                },
            },
            Shared = {
                OtherAnimation = 'scoupleanim2',
            },
        },
    },
    {
        Label = 'Tomar um Drink Feminino',
        Command = 'tdrinkf',
        Animation = 'action_var_01_female',
        Dictionary = 'anim@scripted@robbery@tun_prep_uni_ig1_couple@',
        Options = {
            Flags = {
                Loop = true,
            },
            Props = {
                {
                    Bone = 28422,
                    Name = 'p_wine_glass_s',
                    Placement = {
                        vector3(0.000000, 0.000000, 0.000000),
                        vector3(0.000000, 0.000000, 0.000000),
                    },
                },
            },
            Shared = {
                FrontOffset = 0.11,
                OtherAnimation = 'scoupleanim',
                SideOffset = -0.04125,
            },
        },
    },
    {
        Label = 'Reanimar CPR',
        Command = 'rcpr',
        Animation = 'cpr_pumpchest',
        Dictionary = 'mini@cpr@char_b@cpr_str',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                OtherAnimation = 'scprs',
                Placement = {
                    vector3(0.350000, 0.800000, 0.000000),
                    vector3(0.000000, 0.000000, 270.000000),
                },
            },
        },
    },
    {
        Label = 'Reanimar CPR 2',
        Command = 'rcpr2',
        Animation = 'cpr_loop_victim',
        Dictionary = 'missheistfbi3b_ig8_2',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                OtherAnimation = 'scprs3',
                Placement = {
                    vector3(0.350000, 0.650000, 0.000000),
                    vector3(0.000000, 0.000000, 270.000000),
                },
            },
        },
    },
    {
        Label = 'Passar',
        Command = 'passar',
        Animation = 'givetake1_a',
        Dictionary = 'mp_common',
        Options = {
            Duration = 2000,
            Flags = {
                Move = true,
            },
            Shared = {
                OtherAnimation = 'sgive2',
            },
        },
    },
    {
        Label = 'Passar 2',
        Command = 'passar2',
        Animation = 'givetake1_b',
        Dictionary = 'mp_common',
        Options = {
            Duration = 2000,
            Flags = {
                Move = true,
            },
            Shared = {
                OtherAnimation = 'sgive',
            },
        },
    },
    {
        Label = 'Pagando Bqt',
        Command = 'pbqt',
        Animation = 'pimpsex_hooker',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Duration = 30000,
            Shared = {
                FrontOffset = 0.63,
                OtherAnimation = 'sreceiveblowjob',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Reanimar CPR 3',
        Command = 'rcpr3',
        Animation = 'cpr_pumpchest',
        Dictionary = 'mini@cpr@char_a@cpr_str',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'scprs2',
            },
        },
    },
    {
        Label = 'Reanimar CPR 4',
        Command = 'rcpr4',
        Animation = 'cpr_loop_paramedic',
        Dictionary = 'missheistfbi3b_ig8_2',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'scprs4',
            },
        },
    },
    {
        Label = 'Aperto de Mão',
        Command = 'amao',
        Animation = 'handshake_guy_a',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 3000,
            Flags = {
                Move = true,
            },
            Shared = {
                FrontOffset = 0.9,
                OtherAnimation = 'shandshake2',
            },
        },
    },
    {
        Label = 'Aperto de Mão 2',
        Command = 'amao2',
        Animation = 'handshake_guy_b',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 3000,
            Flags = {
                Move = true,
            },
            Shared = {
                OtherAnimation = 'shandshake',
            },
        },
    },
    {
        Label = 'Cabeçada',
        Command = 'cabecada',
        Animation = 'plyr_takedown_front_headbutt',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Shared = {
                OtherAnimation = 'sheadbutted',
            },
        },
    },
    {
        Label = 'Cabeçada 2',
        Command = 'cabecada2',
        Animation = 'victim_takedown_front_headbutt',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Shared = {
                OtherAnimation = 'sheadbutt',
            },
        },
    },
    {
        Label = 'Abraçar',
        Command = 'abracar',
        Animation = 'kisses_guy_a',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 5000,
            Shared = {
                FrontOffset = 1.05,
                OtherAnimation = 'shug2',
            },
        },
    },
    {
        Label = 'Abraçar 2',
        Command = 'abracar2',
        Animation = 'kisses_guy_b',
        Dictionary = 'mp_ped_interaction',
        Options = {
            Duration = 5000,
            Shared = {
                FrontOffset = 1.18,
                OtherAnimation = 'shug',
            },
        },
    },
    {
        Label = 'Abraçar 3',
        Command = 'abracar3',
        Animation = 'friendship007',
        Dictionary = 'littlespoon@friendship007',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'hugtip2',
            },
        },
    },
    {
        Label = 'Abraçar 4',
        Command = 'abracar4',
        Animation = 'friendship008',
        Dictionary = 'littlespoon@friendship008',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'hugtip',
            },
        },
    },
    {
        Label = 'Abraçar 5',
        Command = 'abracar5',
        Animation = 'chad_armsaround_chad',
        Dictionary = 'misscarsteal2chad_goodbye',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                FrontOffset = 0.52,
                OtherAnimation = 'shug4',
                SideOffset = -0.05,
            },
        },
    },
    {
        Label = 'Abraçar 6',
        Command = 'abracar6',
        Animation = 'chad_armsaround_girl',
        Dictionary = 'misscarsteal2chad_goodbye',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                FrontOffset = 0.52,
                OtherAnimation = 'shug3',
                SideOffset = -0.05,
            },
        },
    },
    {
        Label = 'Beijo',
        Command = 'beijo',
        Animation = 'cs_lestercrest_3_dual-20',
        Dictionary = 'hs3_ext-20',
        Options = {
            Duration = 10000,
            Shared = {
                FrontOffset = 0.08,
                OtherAnimation = 'skiss2',
            },
        },
    },
    {
        Label = 'Beijo 2',
        Command = 'beijo2',
        Animation = 'csb_georginacheng_dual-20',
        Dictionary = 'hs3_ext-20',
        Options = {
            Duration = 10000,
            Shared = {
                FrontOffset = 0.08,
                OtherAnimation = 'skiss',
            },
        },
    },
    {
        Label = 'Beijo 3',
        Command = 'beijo3',
        Animation = 'cs_lestercrest_3_dual-19',
        Dictionary = 'hs3_ext-19',
        Options = {
            Duration = 10000,
            Shared = {
                FrontOffset = 0.08,
                OtherAnimation = 'skiss4',
            },
        },
    },
    {
        Label = 'Beijo 4',
        Command = 'beijo4',
        Animation = 'csb_georginacheng_dual-19',
        Dictionary = 'hs3_ext-19',
        Options = {
            Duration = 10000,
            Shared = {
                FrontOffset = 0.08,
                OtherAnimation = 'skiss3',
            },
        },
    },
    {
        Label = 'Pose 75',
        Command = 'pose75',
        Animation = 'couplepose1pack1anim2_clip',
        Dictionary = 'couplepose1pack1anim2@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'sliftme2',
            },
        },
    },
    {
        Label = 'Pose 76',
        Command = 'pose76',
        Animation = 'couplepose1pack1anim1_clip',
        Dictionary = 'couplepose1pack1anim1@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'sliftme',
                Placement = {
                    vector3(0.002000, 0.287000, 0.250000),
                    vector3(0.000000, 0.000000, 180.000000),
                },
            },
        },
    },
    {
        Label = 'Pose 77',
        Command = 'pose77',
        Animation = 'couplepose2pack1anim2_clip',
        Dictionary = 'couplepose2pack1anim2@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'sliftme4',
            },
        },
    },
    {
        Label = 'Pose 78',
        Command = 'pose78',
        Animation = 'couplepose2pack1anim1_clip',
        Dictionary = 'couplepose2pack1anim1@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'sliftme3',
                Placement = {
                    vector3(0.010000, 0.480000, 0.530000),
                    vector3(0.000000, 0.000000, 180.000000),
                },
            },
        },
    },
    {
        Label = 'Pose 79',
        Command = 'pose79',
        Animation = 'couplepose3pack1anim2_clip',
        Dictionary = 'couplepose3pack1anim2@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                OtherAnimation = 'sliftme6',
            },
        },
    },
    {
        Label = 'Pose 80',
        Command = 'pose80',
        Animation = 'couplepose3pack1anim1_clip',
        Dictionary = 'couplepose3pack1anim1@animation',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'sliftme5',
                Placement = {
                    vector3(-0.212000, -0.540000, -0.100000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Carregar 7',
        Command = 'carregar7',
        Animation = 'mxclip_a',
        Dictionary = 'mx@piggypack_a',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'spback2',
            },
        },
    },
    {
        Label = 'Carregar 8',
        Command = 'carregar8',
        Animation = 'mxanim_b',
        Dictionary = 'mx@piggypack_b',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'spback',
                Placement = {
                    vector3(0.020000, -0.439900, 0.420000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Carregar 9',
        Command = 'carregar9',
        Animation = 'piggyback_c_player_a',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'spback2',
            },
        },
    },
    {
        Label = 'Carregar 10',
        Command = 'carregar10',
        Animation = 'piggyback_c_player_b',
        Dictionary = 'anim@arena@celeb@flat@paired@no_props@',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                Attach = true,
                Bone = 0,
                OtherAnimation = 'spback',
                Placement = {
                    vector3(0.000000, -0.700000, 0.400000),
                    vector3(0.000000, 0.000000, 0.000000),
                },
            },
        },
    },
    {
        Label = 'Soco na Cara',
        Command = 'scara',
        Animation = 'plyr_takedown_rear_lefthook',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Shared = {
                OtherAnimation = 'spunched',
            },
        },
    },
    {
        Label = 'Soco na Cara 2',
        Command = 'scara2',
        Animation = 'victim_takedown_front_cross_r',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Shared = {
                OtherAnimation = 'spunch',
            },
        },
    },
    {
        Label = 'Recebendo bqt',
        Command = 'rbqt',
        Animation = 'pimpsex_punter',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Duration = 30000,
            Shared = {
                FrontOffset = 0.63,
                OtherAnimation = 'sgiveblowjob',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Revistar 3',
        Command = 'revistar3',
        Animation = 'police',
        Dictionary = 'custom@police',
        Options = {
            Flags = {
                Move = true,
            },
            Shared = {
                OtherAnimation = 'ssearch2',
            },
        },
    },
    {
        Label = 'Tapa',
        Command = 'tapa',
        Animation = 'plyr_takedown_front_slap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Duration = 2000,
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'sslapped',
            },
        },
    },
    {
        Label = 'Tapa 2',
        Command = 'tapa2',
        Animation = 'plyr_takedown_front_backslap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Duration = 2000,
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'sslapped2',
            },
        },
    },
    {
        Label = 'Estapear',
        Command = 'estapear',
        Animation = 'victim_takedown_front_slap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Shared = {
                OtherAnimation = 'sslap',
            },
        },
    },
    {
        Label = 'Estapear 2',
        Command = 'estapear2',
        Animation = 'victim_takedown_front_backslap',
        Dictionary = 'melee@unarmed@streamed_variations',
        Options = {
            Shared = {
                OtherAnimation = 'sslap2',
            },
        },
    },
    {
        Label = 'Render',
        Command = 'render',
        Animation = 'biker_02_stickup_loop',
        Dictionary = 'random@countryside_gang_fight',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'sstickupscared',
            },
        },
    },
    {
        Label = 'Ser Rendido',
        Command = 'srendido',
        Animation = 'handsup_base',
        Dictionary = 'missminuteman_1ig_2',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'sstickup',
            },
        },
    },
    {
        Label = 'Sexo Na Rua F',
        Command = 'sruaf',
        Animation = 'shagloop_hooker',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                FrontOffset = 0.5,
                OtherAnimation = 'sstreetsexmale',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Sexo Na Rua M',
        Command = 'sruam',
        Animation = 'shagloop_pimp',
        Dictionary = 'misscarsteal2pimpsex',
        Options = {
            Flags = {
                Loop = true,
            },
            Shared = {
                FrontOffset = 0.5,
                OtherAnimation = 'sstreetsexfemale',
            },
        },
        NSFW = true,
    },
    {
        Label = 'Refém',
        Command = 'refem',
        Animation = 'perp_idle',
        Dictionary = 'anim@gangops@hostage@',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Shared = {
                OtherAnimation = 'shostage2',
            },
        },
    },
    }
