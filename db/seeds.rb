pwd = "userpass"
seed_start_date = 8.months.from_now
sapphire_start_date = 10.months.from_now

## Users
admin = User.create(name: "Admin", email: "an@admin.com", admin: true, password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
organizer = User.create(name: "Event MC", email: "mc@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
track_director = User.create(name: "Track Director", email: "track@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
reviewer = User.create(name: "Reviewer", email: "review@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_reviewer = User.create(name: "Speak and Review", email: "both@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_1 = User.create(name: "Speaker1", email: "speak1@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_2 = User.create(name: "Speaker2", email: "speak2@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_3 = User.create(name: "Speaker3", email: "speak3@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_4 = User.create(name: "Speaker4", email: "speak4@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)
speaker_5 = User.create(name: "Speaker5", email: "speak5@seed.event", password: pwd, password_confirmation: pwd, confirmed_at: Time.now)

# Core Event Info
seed_guidelines = %Q[
# SeedConf wants you!

The first annual conference about seed data is happening
in sunny Phoenix, Arizona on December 1st, 2016!

If your talk is about seed data in Rails apps, we want to hear about it!
]

seed_event = Event.create(name: "SeedConf",
                          slug: "seedconf",
                          url: "http://nativeseed.info/",
                          contact_email: "info@seed.event",
                          closes_at: 6.months.from_now,
                          state: "open",
                          start_date: seed_start_date,
                          end_date: seed_start_date + 1,
                          guidelines: seed_guidelines,
                          proposal_tags: %w(beginner intermediate advanced))

sapphire_guidelines = %Q[
# SapphireConf - The place to be in 2017!

The first annual conference about the hot new programming language Sapphire
is happening in moody Reykjavík, Iceland on February 1st, 2017!

If you are on the cutting edge with savvy Sapphire skills, we want you!
]

sapphire_event = Event.create(name: "SapphireConf",
                              slug: "sapphireconf",
                              url: "https://en.wikipedia.org/wiki/Sapphire",
                              contact_email: "info@sapphire.event",
                              closes_at: 8.months.from_now,
                              state: "draft",
                              start_date: sapphire_start_date,
                              end_date: sapphire_start_date + 1,
                              guidelines: sapphire_guidelines,
                              proposal_tags: %w(beginner intermediate advanced),
                              review_tags: %w(beginner intermediate advanced))

# Session Formats
lightning_talk = seed_event.public_session_formats.create(name: "Lightning Talk", duration: 5, description: "Warp speed! Live your audience breathless and thirsty for more.")
short_session_format = seed_event.public_session_formats.create(name: "Short Talk", duration: 40, description: "Kinda short! Talk fast. Talk hard.")
long_session_format = seed_event.public_session_formats.create(name: "Long Talk", duration: 120, description: "Longer talk allows a speaker put more space in between words, hand motions.")
internal_session_format = seed_event.session_formats.create(name: "Beenote", public: false, duration: 180, description: "Involves live bees.")

# Tracks
track_1 = seed_event.tracks.create(name: "Best Track", description: "Better than all the other tracks.", guidelines: "Watch yourself. Watch everybody else. All of us are winners in the best track.")
track_2 = seed_event.tracks.create(name: "OK Track", description: "The track is okay.", guidelines: "Mediocrity breeds mediocrity. Let's talk about how to transcend the status quo.")
track_3 = seed_event.tracks.create(name: "Boring Track", description: "Great if you want a nap!", guidelines: "Sleep deprivation is linked to many health problem. Get healthy here so you can be 100% for the Best Track.")

# SeedConf Rooms
room_1 = seed_event.rooms.create(name: "Auditorium", room_number: "1000-AUD", level: "1", address: "1510 Blake St", capacity: 300, grid_position: 1, event_id: seed_event.id)
room_2 = seed_event.rooms.create(name: "Atrium", room_number: "1000-ATR", level: "1", address: "1510 Blake St", capacity: 150, grid_position: 2, event_id: seed_event.id)
room_3 = seed_event.rooms.create(name: "Classroom A", room_number: "2100", level: "2", address: "1400 Market St", capacity: 75, grid_position: 3, event_id: seed_event.id)
room_4 = seed_event.rooms.create(name: "Classroom P", room_number: "3500", level: "3", address: "1510 Blake St", capacity: 50, grid_position: 4, event_id: seed_event.id)
room_5 = seed_event.rooms.create(name: "Lobby", room_number: "LOB", level: "1", address: "1400 Market St", capacity: 250, event_id: seed_event.id)

#SapphireConf Rooms
room_1 = sapphire_event.rooms.create(name: "Sun Room", room_number: "SUN", level: "12", address: "123 Universe Drive", capacity: 300, event_id: sapphire_event.id)
room_2 = sapphire_event.rooms.create(name: "Moon Room", room_number: "MOON", level: "6", address: "123 Universe Drive", capacity: 150, event_id: sapphire_event.id)
room_3 = sapphire_event.rooms.create(name: "Venus Theater", room_number: "VEN-T", level: "2", address: "123 Universe Drive", capacity: 75, event_id: sapphire_event.id)

# SeedConf Event Team
seed_event.teammates.create(user: organizer, email: organizer.email, role: "organizer", state: Teammate::ACCEPTED, notifications: false)
seed_event.teammates.create(user: track_director, email: track_director.email, role: "program team", state: Teammate::ACCEPTED)
seed_event.teammates.create(user: reviewer, email: reviewer.email, role: "reviewer", state: Teammate::ACCEPTED)
seed_event.teammates.create(user: speaker_reviewer, email: speaker_reviewer.email, role: "reviewer", state: Teammate::ACCEPTED)

# SapphireConf Event Team
sapphire_event.teammates.create(user: organizer, email: organizer.email, role: "organizer", state: Teammate::ACCEPTED)
sapphire_event.teammates.create(user: track_director, email: track_director.email, role: "program team", state: Teammate::ACCEPTED)
sapphire_event.teammates.create(user: reviewer, email: reviewer.email, role: "reviewer", state: Teammate::ACCEPTED)
sapphire_event.teammates.create(user: speaker_reviewer, email: speaker_reviewer.email, role: "reviewer", state: Teammate::ACCEPTED)

# Seed Conf Proposals
submitted_proposal_1 = seed_event.proposals.create(event_id: seed_event.id,
                                                   uuid: "abc123",
                                                   title: "Honey Bees",
                                                   abstract: "We will discuss the vital importance of pollinators and how we can help them thrive.",
                                                   details: "Why we need pollinators, what plants they love most, basics of how to start your own hive.",
                                                   pitch: "Learning to be stewards for our insect friends is essential to keeping some of our favorite foods around!",
                                                   session_format_id: long_session_format.id,
                                                   track_id: track_1.id)

submitted_proposal_2 = seed_event.proposals.create(event_id: seed_event.id,
                                                   uuid: "def456",
                                                   title: "Coffee Talk",
                                                   abstract: "We go over what makes a great cup of coffee as well as different methods of preparation.",
                                                   details: "We will talk about the coffee plant itself, the roasting process, and prepare the same beans in a variety of different ways to compare the flavor and nuances.",
                                                   pitch: "You need coffee to live happily, why not be drinking the best tasting versions of your favorite drug?",
                                                   session_format_id: long_session_format.id,
                                                   track_id: track_1.id)

accepted_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                state: "accepted",
                                                uuid: "ghi789",
                                                title: "Decorators on Rails",
                                                abstract: "New programmers often have logic-heavy views and models - this talk will offer one potential solution.",
                                                details: "Discussion of where logic should and shouldn't live, how this can happen, and what to do. We will talk some very smelly code and refactor it together!",
                                                pitch: "Is the logic in your views and models getting crazy? Come to this talk to learn how to help alleviate the horror.",
                                                session_format_id: short_session_format.id,
                                                track_id: track_1.id)

waitlisted_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                  state: "waitlisted",
                                                  uuid: "jkl012",
                                                  title: "Javascript for Dummies",
                                                  abstract: "This talk is a basic introduction to Javascript and how to use it effectively.",
                                                  details: "Discussion will include a bit about the history of JS and some high level topics. From there we will learn enough basics to build a simple game together!",
                                                  pitch: "You + Javascript = Besties for Life!!",
                                                  session_format_id: short_session_format.id,
                                                  track_id: track_1.id)

soft_rejected_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                     state: "soft rejected",
                                                     uuid: "mno345",
                                                     title: "Vegan Ice Cream",
                                                     abstract: "This is a hands on class where we will make some delicious dairy-and-egg-free concoctions!",
                                                     details: "Participants will learn the basics of how to make a healthy animal-free ice cream as well as how to come up with amazing flavor combinations.",
                                                     pitch: "Who doesn't love ice cream?",
                                                     session_format_id: internal_session_format.id,
                                                     track_id: track_1.id)

withdrawn_proposal = seed_event.proposals.create(event_id: seed_event.id,
                                                 state: "withdrawn",
                                                 uuid: "pqr678",
                                                 title: "Mystical Vortices",
                                                 abstract: "Learn spiritual energy technics to help cure what ails you.",
                                                 details: "We will enter into the portable vortex I carry in my bag at all times and explore the realms of the unreal.",
                                                 pitch: "Uh, I said VORTICES - what more motivation for coming do you need??",
                                                 session_format_id: long_session_format.id,
                                                 track_id: track_1.id)

# SeedConf Speakers
submitted_proposal_1.speakers.create(speaker_name: speaker_1.name, speaker_email: speaker_1.email, bio: "I am a speaker for cool events!", user_id: speaker_1.id, event_id: seed_event.id)
submitted_proposal_1.speakers.create(speaker_name: speaker_2.name, speaker_email: speaker_2.email, bio: "I know a little bit about everything.", user_id: speaker_2.id, event_id: seed_event.id)
submitted_proposal_2.speakers.create(speaker_name: speaker_2.name, speaker_email: speaker_2.email, bio: "I know a little bit about everything.", user_id: speaker_2.id, event_id: seed_event.id)
accepted_proposal.speakers.create(speaker_name: speaker_3.name, speaker_email: speaker_3.email, bio: "I am a magical unicorn being!", user_id: speaker_3.id, event_id: seed_event.id)
accepted_proposal.speakers.create(speaker_name: speaker_4.name, speaker_email: speaker_4.email, bio: "I am a magical unicorn being!", user_id: speaker_4.id, event_id: seed_event.id)
accepted_proposal.speakers.create(speaker_name: speaker_5.name, speaker_email: speaker_5.email, bio: "I am a magical unicorn being!", user_id: speaker_5.id, event_id: seed_event.id)
waitlisted_proposal.speakers.create(speaker_name: speaker_4.name, speaker_email: speaker_4.email, bio: "I specialize in teaching cutting edge programming techniques to beginners.", user_id: speaker_4.id, event_id: seed_event.id)
soft_rejected_proposal.speakers.create(speaker_name: speaker_5.name, speaker_email: speaker_5.email, bio: "I like cookies and rainbows.", user_id: speaker_5.id, event_id: seed_event.id)
withdrawn_proposal.speakers.create(speaker_name: speaker_1.name, speaker_email: speaker_1.email, bio: "I am a speaker for cool events!", user_id: speaker_1.id, event_id: seed_event.id)


# Taggings
 submitted_proposal_1.taggings.create(proposal_id: submitted_proposal_1.id, tag: "intermediate")
 accepted_proposal.taggings.create(proposal_id: accepted_proposal.id, tag: "beginner")
 waitlisted_proposal.taggings.create(proposal_id: waitlisted_proposal.id, tag: "beginner")
 soft_rejected_proposal.taggings.create(proposal_id: soft_rejected_proposal.id, tag: "beginner")
 withdrawn_proposal.taggings.create(proposal_id: withdrawn_proposal.id, tag: "advanced")

 # Time Slots
